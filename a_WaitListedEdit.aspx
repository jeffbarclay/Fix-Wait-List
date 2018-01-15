<%@ Page Language="VB" MasterPageFile="~/i_MasterPage.master" AutoEventWireup="false" title="MCFRS Tech Training Website - Wait List Edit Admin Lookup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    Start Date:
    	<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>&nbsp; 
    End Date:
    	<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>&nbsp;
    	<asp:Button ID="Button1" runat="server" Text="Go" /><br />
    <br />
	Enrolled:
		<asp:CheckBox ID="CBEnrolled" runat="server" />
	WaitListed:
		<asp:CheckBox ID="CBWaitListed" runat="server" />
	<br>


<%-- 
    <asp:DropDownList ID="DDL_ClassDate" runat="server" AutoPostBack="True" DataSourceID="AccessDataSource2"
        DataTextField="ClassDate" DataValueField="ClassDate">
    </asp:DropDownList>
    (Choose Class Date)
        
    <asp:AccessDataSource ID="AccessDataSource2" runat="server" DataFile="<%$ ConnectionStrings:accessConnectionString %>"
        SelectCommand="SELECT DISTINCT[ClassDate] FROM [EnrollmentsTbl] WHERE [ClassDate] BETWEEN '#11/01/2017#' AND '#12/31/2018#'">
    </asp:AccessDataSource>
    
    <asp:DropDownList ID="DDL_ClassName" runat="server" AutoPostBack="True" DataSourceID="AccessDataSource3"
        DataTextField="ClassName" DataValueField="ClassName">
    </asp:DropDownList>
    (Choose Class Name)
        
    <asp:AccessDataSource ID="AccessDataSource3" runat="server" DataFile="<%$ ConnectionStrings:accessConnectionString %>"
        SelectCommand="SELECT DISTINCT[ClassName] FROM [EnrollmentsTbl] WHERE [Format(ClassDate,'mm/dd/yyyy') AS [ClassDate]] BETWEEN '#11/01/2017#' AND '#12/31/2018#'">
    </asp:AccessDataSource>  
--%>


    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
    BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataKeyNames="EnrollmentsTbl.AutoNum" 
    DataSourceID="AccessDataSource1" ForeColor="Black" GridLines="Vertical" PageSize="100">
        <PagerSettings Mode="NumericFirstLast" PageButtonCount="75" />
        <FooterStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="EnrollmentsTbl.AutoNum" HeaderText="AutoNum" InsertVisible="False" ReadOnly="True" SortExpression="EnrollmentsTbl.AutoNum" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" ReadOnly="True" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" ReadOnly="True" />
            <asp:BoundField DataField="Affiliation" HeaderText="Affiliation" SortExpression="Affiliation" ReadOnly="True" />
            <asp:BoundField DataField="ClassName" HeaderText="ClassName" SortExpression="ClassName" />
            <asp:BoundField DataField="ClassDate" HeaderText="ClassDate" SortExpression="ClassDate" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="False"/>
            <asp:BoundField DataField="ClassTime" HeaderText="ClassTime" SortExpression="ClassTime" />
            <asp:CheckBoxField DataField="Enrolled" HeaderText="Enrolled" SortExpression="Enrolled" />
            <asp:CheckBoxField DataField="WaitListed" HeaderText="WaitListed" SortExpression="WaitListed" />
            <asp:CheckBoxField DataField="Completed" HeaderText="Completed" SortExpression="Completed" />
        </Columns>
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="#6699CC" />
    </asp:GridView>
        
    <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="<%$ ConnectionStrings:accessConnectionString %>"
        DeleteCommand="DELETE FROM [EnrollmentsTbl] WHERE [EnrollmentsTbl.AutoNum] = ?"
        SelectCommand="SELECT [EnrollmentsTbl.AutoNum], [StudentID], [LastName], [FirstName], [Affiliation], [ClassName], 
        Format(ClassDate,'mm/dd/yyyy') AS [ClassDate], [ClassTime], [Enrolled], [WaitListed], [Completed]
        FROM [EnrollmentsTbl] INNER JOIN [UsersDataTbl] ON EnrollmentsTbl.Username = UsersDataTbl.UserName
        WHERE (([Enrolled] = ?) AND ([WaitListed] = ?) AND ([Completed] = ?) AND ([ClassDate] BETWEEN ? AND ?))
        ORDER BY [Affiliation], [ClassName]"
        UpdateCommand="UPDATE [EnrollmentsTbl] SET [ClassName] = ?, [ClassDate] = ?, [ClassTime] = ?, [Enrolled] = ?, [WaitListed] = ?, [Completed] = ? 
        WHERE [AutoNum] = ?">
        <DeleteParameters>
            <asp:Parameter Name="EnrollmentsTbl.AutoNum" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
        	<asp:ControlParameter ControlID="CBEnrolled" Name="Enrolled" PropertyName="Checked" />
        	<asp:ControlParameter ControlID="CBWaitListed" Name="WaitListed" PropertyName="Checked" />
			<asp:Parameter DefaultValue="False" Name="Completed" Type="Boolean" />
			<asp:ControlParameter ControlID="TextBox1" Name="StartDate" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="TextBox2" Name="EndDate" PropertyName="Text" Type="DateTime" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ClassName" Type="String" />
            <asp:Parameter Name="ClassDate" Type="DateTime" />
            <asp:Parameter Name="ClassTime" Type="String" />
            <asp:Parameter Name="Enrolled" Type="Boolean" />
            <asp:Parameter Name="WaitListed" Type="Boolean" />
            <asp:Parameter Name="Completed" Type="Boolean" />
            <asp:Parameter Name="EnrollmentsTbl.AutoNum" Type="Int32" />
        </UpdateParameters>
    </asp:AccessDataSource>

</asp:Content>

<%--	
1/13/2018: cut out the following code from <SelectCommand>:
([Enrolled] = ?) AND 
AND ([WaitListed] = ?) 

and cut the following from <SelectParameters>:
<asp:Parameter DefaultValue="True" Name="Enrolled" Type="Boolean" />
<asp:Parameter DefaultValue="True" Name="WaitListed" Type="Boolean" />

************************************************************
<asp:Parameter DefaultValue="True" Name="Enrolled" Type="Boolean" />
<asp:Parameter DefaultValue="False" Name="Completed" Type="Boolean" />
<asp:Parameter DefaultValue="False" Name="WaitListed" Type="Boolean" />

<asp:ControlParameter DefaultValue="True" ControlID="CBEnrolled" Name="Enrolled" PropertyName="Text" Type="Boolean" />
<asp:Parameter DefaultValue="False" Name="Completed" Type="Boolean" />
<asp:ControlParameter DefaultValue="True" ControlID="CheckBox1" Name="WaitListed" PropertyName="Text" Type="Boolean" />
            
--%>
 