<%@ Page Language="VB" MasterPageFile="../s_MasterPage.master" CodeFile="s_reg.aspx.vb" Inherits="s_reg" title="Student Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
        <h2><font color="#FF6666">Student Registration </font></h2>
        
        <p>
            <asp:LoginView ID="LoginView1" runat="server">
                
                <LoggedInTemplate>
  <!--  LoggedInView -->
                    <table>
                        <tr>
                            <td style="width: 100px" valign="top">
        <asp:DropDownList ID="DropDownClasses" runat="server" DataSourceID="AccessDataSource2" DataTextField="ClassName" DataValueField="ClassName" AutoPostBack="true">
        </asp:DropDownList>
        <asp:AccessDataSource ID="AccessDataSource2" runat="server" DataFile="<%$ ConnectionStrings:accessConnectionString %>"
            SelectCommand="SELECT DISTINCT [ClassName] FROM [ClassesTbl] WHERE [Cancelled] = False AND ClassDate > Now()"></asp:AccessDataSource>
                            </td>
                            <td>
                                <asp:GridView ID="GridView1" runat="server" DataSourceID="AccessDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false">
                                    <Columns>
                                        <asp:CommandField ShowSelectButton="True" ButtonType="Button" SelectText="Register" />
                                        <asp:BoundField DataField="ClassName" HeaderText="Class Name" SortExpression="ClassName" />
                                        <asp:BoundField DataField="ClassDate" HeaderText="Class Date" SortExpression="ClassDate" DataFormatString="{0:MM/dd/yyyy}" HtmlEncode="false" />
                                        <asp:BoundField DataField="ClassTime" HeaderText="Class Time" SortExpression="ClassTime" />
                                        <asp:BoundField DataField="Duration" HeaderText="Duration (hrs.)" SortExpression="Duration" />
                                    </Columns>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                                    <EmptyDataTemplate>
                                        There are no dates available for this class at the present time.
                                    </EmptyDataTemplate>
                                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                                    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#FF6666" Font-Bold="True" ForeColor="White" />
                                    <AlternatingRowStyle BackColor="White" />
                                </asp:GridView>
                                <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="<%$ ConnectionStrings:accessConnectionString %>"
                                    SelectCommand="SELECT [ClassName], [ClassDate], [ClassTime], [Duration] FROM [ClassesTbl] WHERE (([Cancelled] = ?) AND ([ClassName] = ?) AND ([ClassDate] >= Now)) ORDER BY [ClassDate]">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="False" Name="Cancelled" Type="Boolean" />
                                        <asp:ControlParameter ControlID="DropDownClasses" Name="ClassName" PropertyName="SelectedValue"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:AccessDataSource>
                            </td>
                        </tr>
                    </table>
        
         
                </LoggedInTemplate>
                
                
                
                <AnonymousTemplate>
                    
                    New member? Please register for a new account by filling in the fields below. 
                    <br />
                    <br />
                    If you have ever taken a tech class within MCFRS, you probably already have an account
                    (either created for you or by you).
                    <br />
                    Note:
                    This is page 1 of a multi-page registration. Once you have filled in the fields, please
                    click the <strong>Create User</strong> button. When your account has been
                    created, click the <strong>Continue</strong> button and you will be prompted to
                    input your name, Fire ID and affiliation. You should not register for classes until
                    your name and affiliation are in the system.<br />
                    <br />
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BackColor="#F7F7DE" BorderColor="#CCCC99"
            BorderStyle="Solid" BorderWidth="1px" LoginCreatedUser="True" ContinueDestinationPageUrl="s_CreateUser.aspx"
            Font-Names="Verdana" Font-Size="10pt">
            <SideBarStyle BackColor="#7C6F57" BorderWidth="0px" Font-Size="0.9em" VerticalAlign="Top" />
            <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />
            <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
                BorderWidth="1px" Font-Names="Verdana" ForeColor="#284775" />
            <HeaderStyle BackColor="#F7F7DE" BorderStyle="Solid" Font-Bold="True" Font-Size="0.9em"
                ForeColor="White" HorizontalAlign="Left" />
            <CreateUserButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
                BorderWidth="1px" Font-Names="Verdana" ForeColor="#284775" />
            <ContinueButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
                BorderWidth="1px" Font-Names="Verdana" ForeColor="#284775" />
            <StepStyle BorderWidth="0px" />
            <TitleTextStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            
            
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                    
                    <ContentTemplate>
                        <table border="0" style="font-size: 100%; font-family: Verdana">
                            <tr>
                                <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #6b696b">
                                    Sign Up for
                                    Your New Account</td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                        ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                        ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required."
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                        ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">Security Question:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" ControlToValidate="Question"
                                        ErrorMessage="Security question is required." ToolTip="Security question is required."
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">Security Answer:</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" ControlToValidate="Answer"
                                        ErrorMessage="Security answer is required." ToolTip="Security answer is required."
                                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                        ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                                        ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color: red; height: 18px">
                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
                
                
                </AnonymousTemplate>
                
                
            </asp:LoginView>
            &nbsp;</p>     
  </asp:Content>