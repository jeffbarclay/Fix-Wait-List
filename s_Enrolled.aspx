<%@ Page Language="VB" Debug="true" MasterPageFile="~/s_MasterPage.master" AutoEventWireup="false" CodeFile="s_Enrolled.aspx.vb" Inherits="s_Enrolled" title="Your Current Class Registrations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>
        Current Classes Enrolled In</h2>
    <p>
        
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoNum"
            DataSourceID="AccessDataSource1" OnRowDeleting="GridView1_RowDeleting" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" 
            CellPadding="3" ForeColor="Black" GridLines="Vertical">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Disenroll" />
                <asp:BoundField DataField="ClassName" HeaderText="Class Name" SortExpression="ClassName" />
                <asp:BoundField DataField="ClassDate" HeaderText="Class Date" SortExpression="ClassDate" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="False"/>
                <asp:BoundField DataField="ClassTime" HeaderText="Class Time" SortExpression="ClassTime" />
                <asp:BoundField DataField="WaitListed" HeaderText="Wait Listed" SortExpression="WaitListed" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="#6699CC" />
        </asp:GridView>
        
        
        <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="<%$ ConnectionStrings:accessConnectionString %>"
            DeleteCommand="UPDATE [EnrollmentsTbl] SET [Enrolled] = False WHERE [AutoNum] = ?" 
            SelectCommand="SELECT [AutoNum], [ClassName], [ClassDate], [ClassTime], [WaitListed] FROM [EnrollmentsTbl] WHERE ([UserName] = ?) AND ([Enrolled] = True) AND ([Completed] = False) AND ([ClassDate] >= Now)">
            <SelectParameters>
                <asp:SessionParameter Name="UserName" SessionField="UserID" Type="String" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="AutoNum" Type="Int32" />
            </DeleteParameters>
        </asp:AccessDataSource>
        
        <asp:label id="myLabel" runat="server" /><br>
        <asp:label id="myLabel1" runat="server" /><br>
        <asp:label id="myLabel2" runat="server" /><br>
        <asp:label id="myLabel3" runat="server" /><br>
        <asp:label id="myLabel4" runat="server" /><br>
    
    </p>
</asp:Content>

<%--
LOOK INTO FUTURE CHANGE TO UPDATE in DeleteCommand to not only set enrolled to false 
but set waitlisted to false or even delete full record.
--%>