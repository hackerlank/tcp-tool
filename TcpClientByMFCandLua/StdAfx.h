// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__D322A24B_2AA2_498F_9E82_621ADE89749A__INCLUDED_)
#define AFX_STDAFX_H__D322A24B_2AA2_498F_9E82_621ADE89749A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers

#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxdisp.h>        // MFC Automation classes
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT

#include <afxsock.h>		// MFC socket extensions

// 包含皮肤头文件
#include "SkinH.h"
#pragma comment(lib, "Skinh.lib")


// 包含lua头文件
extern "C" {
#include "lua/lua.hpp"
#include "lua/lua.h"
#include "lua/lualib.h"
#include "lua/lauxlib.h"
}

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__D322A24B_2AA2_498F_9E82_621ADE89749A__INCLUDED_)
