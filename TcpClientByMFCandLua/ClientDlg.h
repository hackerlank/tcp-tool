// ClientDlg.h : header file
//

#if !defined(AFX_CLIENTDLG_H__61BE7727_6276_4E95_B971_47DE3E9537A6__INCLUDED_)
#define AFX_CLIENTDLG_H__61BE7727_6276_4E95_B971_47DE3E9537A6__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "ClientSocket.h"
#define WM_NET_MESSAGE (WM_USER+100)
/////////////////////////////////////////////////////////////////////////////
// CClientDlg dialog

class CClientDlg : public CDialog
{
// Construction
public:
	CClientDlg(CWnd* pParent = NULL);	// standard constructor
	
private:
	static CClientSocket * s_pClientSocket;
	lua_State* L;
	CString m_strIniPath;
public:
	void LoadConfig();
	void SaveConfig();

	LRESULT NETMessage(WPARAM wParam, LPARAM lParam);
	void OnConnect();
	void OnConnectFailed();
	void OnDisConnect();
	int OnRecvData(const char* s, int len);
	// 提供接口给lua调用
	static int SendData(lua_State* L);

// Dialog Data
	//{{AFX_DATA(CClientDlg)
	enum { IDD = IDD_CLIENT_DIALOG };
	CEdit	m_edtContent2;
	CComboBox	m_cmbProto2;
	CButton	m_btnSend2;
	CComboBox	m_cmbProto;
	CButton	m_btnClose;
	CButton	m_btnSend;
	CButton	m_btnConnect;
	CEdit	m_edtContent;
	CEdit	m_edtPort;
	CEdit	m_edtIP;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CClientDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CClientDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButtonConnect();
	afx_msg void OnButtonClose();
	afx_msg void OnButtonSend();
	afx_msg void OnButtonClear();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnButtonSend2();
	afx_msg void OnButtonClear2();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CLIENTDLG_H__61BE7727_6276_4E95_B971_47DE3E9537A6__INCLUDED_)
