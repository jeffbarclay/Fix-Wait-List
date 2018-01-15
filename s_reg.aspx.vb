Partial Class s_reg
    Inherits System.Web.UI.Page
    
    
    Protected Sub GridView1_SelectedIndexChanged1(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim c As DropDownList = Me.LoginView1.FindControl("DropDownClasses")
        Dim ClassName As String
        Dim ClassDate As String
        Dim ClassTime As String
        Dim UserName As String = User.Identity.Name()

        If (Not IsNothing(c)) Then
            If (Not IsNothing(c.SelectedItem)) Then
                ClassName = c.SelectedItem.Text
                Response.Write("<br>The Class is: " & ClassName)
            End If
        End If

        Dim gv As GridView = CType(sender, GridView)
        Dim row As GridViewRow = gv.SelectedRow
        
        If (row Is Nothing) Then
            ClassDate = ""
            ClassTime = ""
        End If
        
        ClassName = row.Cells(1).Text
        ClassDate = row.Cells(2).Text
        ClassTime = row.Cells(3).Text
        'Response.Write("<br>The Date is: " & row.Cells(2).Text & "<br> Class Time is " & row.Cells(3).Text & "<br>")

        CreateEnrollment(UserName, ClassDate, ClassTime, ClassName)
        UpdateLastActivityDate(UserName)
        SessionEnrollment(ClassName, ClassDate, ClassTime)
        Response.Redirect("smtpClassConfirmation.aspx")
    End Sub
    
    
    Public Function CreateEnrollment(ByVal UserName As String, ByVal ClassDate As Date, ByVal ClassTime As String, ByVal ClassName As String)
        Dim MaxStudents As Integer = GetMaxStudents(ClassName, ClassDate, ClassTime)
        Dim waitlist As Integer = CheckWaitList(ClassName, ClassDate, ClassTime)
'       Dim Updatewaitlist As Boolean = GetUpdateWaitList(ClassName, ClassDate, ClassTime) ** function not created yet
        Dim waitlisted As Boolean

        If waitlist > MaxStudents Then
            waitlisted = True
        Else
            waitlisted = False
        End If

        Session("waitlisted") = waitlisted

        Dim connStr As String = ConfigurationManager.AppSettings.Get("TechTrainingConn")
        Dim conn As New Data.OleDb.OleDbConnection(connStr)

        conn.Open()
        Dim sql As String = "INSERT INTO EnrollmentsTbl (" & _
        "[UserName],[SubmitTime],[ClassTime],[ClassDate],[Enrolled],[ClassName],[WaitListed]) VALUES " & _
        "(@UserName, @SubmitTime, @ClassTime, @ClassDate, @Enrolled, @ClassName, @WaitListed) "

        Dim comm As New Data.OleDb.OleDbCommand(sql, conn)

        comm.Parameters.AddWithValue("@UserName", UserName)
        comm.Parameters.AddWithValue("@SubmitTime", DateTime.Now.ToString())
        comm.Parameters.AddWithValue("@ClassTime", ClassTime)
        comm.Parameters.AddWithValue("@ClassDate", ClassDate)
        comm.Parameters.AddWithValue("@Enrolled", True)
        comm.Parameters.AddWithValue("@ClassName", ClassName)
        comm.Parameters.AddWithValue("@WaitListed", waitlisted)
        Dim result As Integer = comm.ExecuteNonQuery()
        conn.Close()

        Return True
    End Function
    
    
    Public Function UpdateLastActivityDate(ByVal username As String) As Boolean

        Dim connStr As String = ConfigurationManager.AppSettings.Get("TechTrainingConn")
        Dim conn As New Data.OleDb.OleDbConnection(connStr)

        conn.Open()

        Dim sql As String = "UPDATE [Users] SET [LastActivityDate] = #" & Date.Now.ToString() & "# " & _
             " WHERE [UserName] = """ & username & """"
        Dim comm As New Data.OleDb.OleDbCommand(sql, conn)
        Dim result As Integer = comm.ExecuteNonQuery()
        conn.Close()

        Return True

    End Function
 
    
    Public Sub SessionEnrollment(ByVal ClassName As String, ByVal ClassDate As Date, ByVal ClassTime As String)
        Session("ClassTime") = ClassTime
        Session("ClassDate") = Strings.Left(ClassDate, 10)
        Session("ClassName") = ClassName
    End Sub
 
    
    Public Function CheckWaitList(ByVal ClassName As String, ByVal ClassDate As Date, ByVal ClassTime As String) As Integer
        Dim connStr As String = ConfigurationManager.AppSettings.Get("TechTrainingConn")
        Dim conn As New Data.OleDb.OleDbConnection(connStr)
        Dim sql As String = "SELECT COUNT(*) FROM [EnrollmentsTbl]" & _
                           " WHERE [ClassName] = """ & ClassName & """" & _
                           " AND [ClassDate] = #" & ClassDate & "#" & _
                           " AND [ClassTime] = """ & ClassTime & """" & _
                           " AND [Enrolled] = true"
        Dim DBCommand As New Data.OleDb.OleDbCommand(sql, conn)
        Try
            conn.Open()
            Dim RecordCount As Integer = CInt(DBCommand.ExecuteScalar())
            conn.Close()

            Return RecordCount

        Catch ex As Exception
            Response.Write(ex)
        Finally
            conn.Close()
        End Try

    End Function
    
   
    Public Function GetMaxStudents(ByVal ClassName As String, ByVal ClassDate As Date, ByVal ClassTime As String) As Integer
        Dim objConn As Data.OleDb.OleDbConnection
        Dim objCmd As Data.OleDb.OleDbCommand
        Dim objRdr As Data.OleDb.OleDbDataReader
        Dim MaxStudents As Integer
        Dim strConnection As String = ConfigurationManager.AppSettings.Get("TechTrainingConn")

        objConn = New Data.OleDb.OleDbConnection(strConnection)
        objCmd = New Data.OleDb.OleDbCommand("SELECT [MaxStudents] FROM ClassesTbl " & _
        "WHERE [ClassName] = """ & ClassName & """ AND [ClassDate] = #" & ClassDate & "# " & _
        "AND [ClassTime] = """ & ClassTime & """ ", objConn)
        Try
            objConn.Open()
            objRdr = objCmd.ExecuteReader()

            While objRdr.Read()
                MaxStudents = objRdr.Item("MaxStudents")
            End While
            objRdr.Close()
            objConn.Close()

            Return MaxStudents

        Catch ex As Exception
            Return 0
        Finally
            objConn.Close()
        End Try
        
    End Function
End Class
