// ClientDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Client.h"
#include "ClientDlg.h"

#include<shlwapi.h>
#pragma comment(lib,"Shlwapi.lib")

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

CClientSocket * CClientDlg::s_pClientSocket = new CClientSocket();


class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CClientDlg dialog

CClientDlg::CClientDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CClientDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CClientDlg)
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	s_pClientSocket->SetMessagePara(this,WM_NET_MESSAGE);
	L = NULL;
}

void CClientDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CClientDlg)
	DDX_Control(pDX, IDC_EDIT_CONTENT2, m_edtContent2);
	DDX_Control(pDX, IDC_COMBO_PROTO2, m_cmbProto2);
	DDX_Control(pDX, IDC_BUTTON_SEND2, m_btnSend2);
	DDX_Control(pDX, IDC_COMBO_PROTO, m_cmbProto);
	DDX_Control(pDX, IDC_BUTTON_CLOSE, m_btnClose);
	DDX_Control(pDX, IDC_BUTTON_SEND, m_btnSend);
	DDX_Control(pDX, IDC_BUTTON_CONNECT, m_btnConnect);
	DDX_Control(pDX, IDC_EDIT_CONTENT, m_edtContent);
	DDX_Control(pDX, IDC_EDIT_PORT, m_edtPort);
	DDX_Control(pDX, IDC_EDIT_IP, m_edtIP);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CClientDlg, CDialog)
	//{{AFX_MSG_MAP(CClientDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_CONNECT, OnButtonConnect)
	ON_BN_CLICKED(IDC_BUTTON_CLOSE, OnButtonClose)
	ON_BN_CLICKED(IDC_BUTTON_SEND, OnButtonSend)
	ON_BN_CLICKED(IDC_BUTTON_CLEAR, OnButtonClear)
	ON_WM_TIMER()
	ON_BN_CLICKED(IDC_BUTTON_SEND2, OnButtonSend2)
	ON_BN_CLICKED(IDC_BUTTON_CLEAR2, OnButtonClear2)
	//}}AFX_MSG_MAP
	ON_MESSAGE(WM_NET_MESSAGE,NETMessage)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CClientDlg message handlers

void CClientDlg::LoadConfig()
{
	// �õ�exeִ��·��.  
	TCHAR tcExePath[MAX_PATH] = {0};  
    ::GetModuleFileName(NULL, tcExePath, MAX_PATH);  
    // ����ini·����exeͬһĿ¼��  
#ifndef CONFIG_FILE  
	#define CONFIG_FILE     (TEXT("Config.ini"))  
#endif  
    //_tcsrchr() ��������������һ��'\\'��λ�ã������ظ�λ�õ�ָ��  
    TCHAR *pFind = _tcsrchr(tcExePath, '\\');  
    if (pFind == NULL)  
    {  
        return ;  
    }  
    *pFind = '\0';  
    m_strIniPath = tcExePath;  
    m_strIniPath += "\\";  
    m_strIniPath += CONFIG_FILE;  // ���յõ�config.ini·��
	
	if (false == PathFileExists(m_strIniPath.GetBuffer(0))) // �����ļ���������Ĭ�ϴ���д��
	{
		::WritePrivateProfileString(TEXT("Server"), TEXT("ip"), TEXT("127.0.0.1"), m_strIniPath);  
		::WritePrivateProfileString(TEXT("Server"), TEXT("port"), TEXT("8888"), m_strIniPath);
		::WritePrivateProfileString(TEXT("Server"), TEXT("content"), TEXT(""), m_strIniPath);
		::WritePrivateProfileString(TEXT("Server"), TEXT("content2"), TEXT(""), m_strIniPath);
	}

	// ��ȡ����
	TCHAR szIP[MAX_PATH] = {0};
	::GetPrivateProfileString(TEXT("Server"), TEXT("ip"), NULL, szIP, MAX_PATH, m_strIniPath);  
	m_edtIP.SetWindowText(szIP);

    int nPort = ::GetPrivateProfileInt(TEXT("Server"), TEXT("port"), 8888, m_strIniPath); 
	CString strPort;
	strPort.Format("%d", nPort);
	m_edtPort.SetWindowText(strPort);

	TCHAR szContent[MAX_PATH] = {0};
	::GetPrivateProfileString(TEXT("Server"), TEXT("content"), NULL, szContent, MAX_PATH, m_strIniPath);  
	m_edtContent.SetWindowText(szContent);

	TCHAR szContent2[MAX_PATH] = {0};
	::GetPrivateProfileString(TEXT("Server"), TEXT("content2"), NULL, szContent2, MAX_PATH, m_strIniPath);  
	m_edtContent2.SetWindowText(szContent2);
}

void CClientDlg::SaveConfig()
{
	CString strIP = (_T(""));
	m_edtIP.GetWindowText(strIP);
	CString strPort = (_T(""));
	m_edtPort.GetWindowText(strPort);
	CString strContent = (_T(""));
	m_edtContent.GetWindowText(strContent);
	CString strContent2 = (_T(""));
	m_edtContent2.GetWindowText(strContent2);
	// ����������Ϣ
	::WritePrivateProfileString(TEXT("Server"), TEXT("ip"), TEXT(strIP), m_strIniPath);  
	::WritePrivateProfileString(TEXT("Server"), TEXT("port"), TEXT(strPort), m_strIniPath);
	::WritePrivateProfileString(TEXT("Server"), TEXT("content"), TEXT(strContent), m_strIniPath);
	::WritePrivateProfileString(TEXT("Server"), TEXT("content2"), TEXT(strContent2), m_strIniPath);
}


BOOL CClientDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	LoadConfig();
	m_btnClose.EnableWindow(FALSE);
	m_btnSend.EnableWindow(FALSE);
	m_btnSend2.EnableWindow(FALSE);
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CClientDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CClientDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CClientDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

LRESULT CClientDlg::NETMessage(WPARAM wParam, LPARAM lParam)
{
	CString strContent;
	char * str = NULL;
	int len = 0;
	switch(wParam){
	case ONCONNECT:
			// printf("���ӷ������ɹ�!!!\n");
			OnConnect();
			break;
	case ONCONNECTFAILED:
			// printf("���ӷ�����ʧ��!!!\n");
			OnConnectFailed();
			break;	
	case ONRECVDATA:
			//printf("�յ�����������!!!\n");
			str = s_pClientSocket->GetRecvData(len);
			OnRecvData(str, len);
			break;
	case ONDISCONNECT:
			// printf("�������ѹر�!!!\n");
			OnDisConnect();
			break;
	case CLIENTSEND:
			// printf("�ͻ��ķ������ݳɹ�!!!\n");
			break;
	case CLIENTCLOSE:
			// printf("�ͻ������ر�����!!!\n");
			OnDisConnect();
			break;
	}

	UpdateData(false);

	return TRUE;
}

void CClientDlg::OnButtonConnect() 
{
	UpdateData(true);
	s_pClientSocket->ShutDown(2);
	s_pClientSocket->Rest();
	if (s_pClientSocket->m_hSocket == INVALID_SOCKET)
	{
		BOOL bFlag=s_pClientSocket->Create(0,SOCK_STREAM,FD_CONNECT);
		if(!bFlag)
		{	
			AfxMessageBox("socket����ʧ�� !");
			s_pClientSocket->Close();
			return;
		}
	}
	CString strIP = (_T(""));
	m_edtIP.GetWindowText(strIP);
	CString strPort = (_T(""));
	m_edtPort.GetWindowText(strPort);
	s_pClientSocket->Connect(strIP,atoi(strPort));
	SaveConfig();
}

void CClientDlg::OnButtonClose() 
{
	s_pClientSocket->Close();
}


void CClientDlg::OnButtonSend() 
{
	UpdateData(true);
	int nIndex = m_cmbProto.GetCurSel();
	if (-1 == nIndex)
	{
		AfxMessageBox("��ѡ��Э������ !");
		return ;
	}
	CString strContent = (_T(""));
	m_edtContent.GetWindowText(strContent);
	if (_T("") != strContent)
	{
		CString strProto;
		m_cmbProto.GetLBText( nIndex, strProto);
		if (NULL == L)
		{
			printf("lua_State is NULL");
			return ;
		}
		lua_getglobal(L, "on_send");
		lua_pushstring(L, strProto);
		lua_pushstring(L, strContent);
		lua_pcall(L, 2, 0, 0);
	}else
	{
		AfxMessageBox("�����·�������Ϣ���� !");
	}

	SaveConfig();
}

void CClientDlg::OnButtonClear() 
{
	m_edtContent.SetWindowText(_T(""));
	SaveConfig();
}

void CClientDlg::OnButtonSend2() 
{
	// TODO: Add your control notification handler code here
	UpdateData(true);
	int nIndex = m_cmbProto2.GetCurSel();
	if (-1 == nIndex)
	{
		AfxMessageBox("��ѡ��Э������ !");
		return ;
	}
	CString strContent = (_T(""));
	m_edtContent2.GetWindowText(strContent);
	if (_T("") != strContent)
	{
		CString strProto;
		m_cmbProto2.GetLBText( nIndex, strProto);
		if (NULL == L)
		{
			printf("lua_State is NULL");
			return ;
		}
		lua_getglobal(L, "on_send");
		lua_pushstring(L, strProto);
		lua_pushstring(L, strContent);
		lua_pcall(L, 2, 0, 0);
	}else
	{
		AfxMessageBox("�����·�������Ϣ���� !");
	}

	SaveConfig();
}

void CClientDlg::OnButtonClear2() 
{
	// TODO: Add your control notification handler code here
	m_edtContent2.SetWindowText(_T(""));
	SaveConfig();
}


void CClientDlg::OnTimer(UINT nIDEvent) 
{
	// TODO: Add your message handler code here and/or call default
	if (NULL == L)
	{
		printf("lua_State is NULL");
		return ;
	}
	lua_getglobal(L, "on_heart"); 
	lua_pcall(L, 0, 0, 0);
	CDialog::OnTimer(nIDEvent);
}
///////////////////////////////////////////////////////////
// ���ӽ���
void CClientDlg::OnConnect()
{
	m_btnConnect.EnableWindow(false);
	m_btnClose.EnableWindow(true);
	m_btnSend.EnableWindow(true);
	m_btnSend2.EnableWindow(true);
	m_edtIP.EnableWindow(false);
	m_edtPort.EnableWindow(false);

	// ����luaģ��
	L = luaL_newstate();
	luaL_openlibs(L);
	lua_register(L, "sendData", CClientDlg::SendData);
	int ret = luaL_dofile(L, "script/main.lua");
	if (ret != 0){
		//printf("Error occurs when calling luaL_dofile() Hint Machine 0x%x\n",ret);
		//printf("Error: %s", lua_tostring(L,-1));
		CString erroInfo = _T("Error:");
		erroInfo +=  lua_tostring(L,-1);
		AfxMessageBox(erroInfo, MB_OK | MB_ICONSTOP );
	}else{
		printf("����luaģ��ɹ�!!!\n");
	}	

	// ��ʼ����Ͽ�Э���б�
	m_cmbProto.ResetContent();
	lua_getglobal(L, "on_get_proto_list"); 
	lua_pcall(L, 0, 1, 0);
	lua_pushnil(L); 
	CString strValue;
	CString strKey;
	while (lua_next(L, -2)) {  
		 strValue = lua_tostring(L, -1);  
		 strKey = lua_tostring(L, -2);  
		 m_cmbProto.AddString(strValue);
		 m_cmbProto2.AddString(strValue);
		 lua_pop(L, 1);  
	}  
	int nCount = m_cmbProto.GetCount();	
	if (nCount > 0){
		m_cmbProto.SetCurSel(0); // ����Ĭ��ѡ���һ��Э��
		m_cmbProto2.SetCurSel(0); // ����Ĭ��ѡ���һ��Э��
	}

	lua_getglobal(L, "on_connect"); 
	lua_pcall(L, 0, 0, 0);
	// ��ʱ��֤on_connect����ȫִ��
	Sleep(400);
	// ������ʱ��
	SetTimer(1,1000,NULL); 
}

// ����ʧ��
void CClientDlg::OnConnectFailed()
{
	m_btnConnect.EnableWindow(true);
	m_btnClose.EnableWindow(false);
	m_btnSend.EnableWindow(false);
	m_btnSend2.EnableWindow(false);
	m_edtIP.EnableWindow(true);
	m_edtPort.EnableWindow(true);
	AfxMessageBox("���ӷ�����ʧ�� !");
}

// ���ӶϿ�
void CClientDlg::OnDisConnect()
{
	m_btnConnect.EnableWindow(true);
	m_btnClose.EnableWindow(false);
	m_btnSend.EnableWindow(false);
	m_cmbProto.ResetContent();
	m_btnSend2.EnableWindow(false);
	m_cmbProto2.ResetContent();
	m_edtIP.EnableWindow(true);
	m_edtPort.EnableWindow(true);

	lua_getglobal(L, "on_disconnect"); 
	lua_pcall(L, 0, 0, 0);

	KillTimer(1);
	lua_close(L);
	L = NULL;
	printf("ж��luaģ��ɹ�!!!\n");
}

// ���յ����ݣ�����lua on_recv�ӿ�
int CClientDlg::OnRecvData(const char* s, int len)
{
	if (NULL == L)
	{
		printf("lua_State is NULL");
		return 0;
	}
	lua_getglobal(L, "on_recv");
	lua_pushlstring(L, s, len); // ��Զ���������
	lua_pcall(L, 1, 0, 0);
	return 1;
}


//////////////////////////////////////////////////////////////////
// �ṩ�ӿڸ�lua����
int CClientDlg::SendData(lua_State* L) 
{
	int len = lua_tonumber(L,-1);
	const char * str = lua_tostring(L,-2);
	s_pClientSocket->SendData(str, len);
	return 1;
}


