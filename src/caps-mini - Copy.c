/*
	CapsLang by Ryurik 2003-11-12, updated 2006-10-24
    Edit 2025-07 by @urasssopretty (github)

	This small windowless program allow you swich keyboard layout with CapsLock key.
	While non-standard keyboard layout will bright Scroll Lock indicator

	Installation: copy capslang.exe to your Startup (Start -> Programs) folder.
	Run: Just run capslang.exe and enjoy
	Exit: To close programm press Ctrl + Alt + L
	Note: Does not work with Win9x!
 */

#include <windows.h>
#include <tchar.h>

#define EXIT 33
#define LETTER_L_KEY 'L'
#define CAPS_LOCK_KEY VK_CAPITAL
#define SHIFT_KEY VK_SHIFT
// #define INPUTLANGCHANGE_FORWARD 2


HHOOK caps_khook;


LRESULT CALLBACK keyboard_hook(int nCode, WPARAM wParam, LPARAM lParam);
void formatted_messagebox(const TCHAR *msg);


int APIENTRY WinMain(HINSTANCE hInst, HINSTANCE hInstPrev, LPSTR cmd, int show)
{
    // an event is created to ensure
    // that the program will run in a single instance
    HANDLE hCapsLangEvent = CreateEvent(NULL, TRUE, FALSE, _T("CapsLang"));

    // if event creation fails
    if (hCapsLangEvent == NULL)
    {
		formatted_messagebox(_T("CreateEvent"));
        return 1;
    }

    // if the event was successfully created
    // but another instance of CapsLang is running
    if (GetLastError() == ERROR_ALREADY_EXISTS)
    {
    	MessageBox(
            NULL,
            _T("CapsLang is already running!"),
            _T("ERROR: CapsLang is already running!"),
            MB_OK | MB_ICONERROR
        );
        return 1;
	}

    // registration of Ctrl + Alt + L hotkey to close CapsLang
	if (RegisterHotKey(0, EXIT, MOD_CONTROL | MOD_ALT, LETTER_L_KEY) == 0)
    {
		formatted_messagebox(_T("RegisterHotKey"));
        return 1;
    }

    // setup hook
	caps_khook = SetWindowsHookEx(WH_KEYBOARD_LL, keyboard_hook, GetModuleHandle(0), 0);
	if (caps_khook == 0)
    {
		formatted_messagebox(_T("SetWindowsHookEx"));
        return 1;
    }


	MSG msg;

    // read messages
	while (GetMessage(&msg, 0, 0, 0))
    {
		TranslateMessage(&msg);
		if(msg.message == WM_HOTKEY && msg.wParam == EXIT)
            PostQuitMessage(0);
		DispatchMessage(&msg);
	}

	UnhookWindowsHookEx(caps_khook);
	CloseHandle(hCapsLangEvent);

	return 0;
}


LRESULT CALLBACK keyboard_hook(int nCode, WPARAM wParam, LPARAM lParam)
{
    do
    {
        if (nCode != HC_ACTION) break;

        const KBDLLHOOKSTRUCT* keyboard_input_info = (KBDLLHOOKSTRUCT*)lParam;
        const int is_capslock_event = (keyboard_input_info->vkCode == CAPS_LOCK_KEY);
        const int is_capslock_pressed = is_capslock_event && (wParam == WM_KEYDOWN);
        const int is_shift_pressed = (GetKeyState(VK_SHIFT) < 0);

        // if CapsLock is NOT pressed or Shift is pressed
        // then do nothing
        // otherwise if CapsLock is pressed or Shift is NOT pressed
        // then it is necessary to change the keyboard layout language
        if (!is_capslock_pressed || is_shift_pressed) break;


        HWND focusedWindow = GetForegroundWindow();
        if (focusedWindow == NULL) break;

        // send a message to the focused window that it is necessary
        // to change the keyboard layout to the following one
        PostMessage(focusedWindow, WM_INPUTLANGCHANGEREQUEST, 0, HKL_NEXT);
        return TRUE;

    } while (FALSE);

	return CallNextHookEx(caps_khook, nCode, wParam, lParam);
}

void formatted_messagebox(const TCHAR *original_message)
{
	TCHAR *error_buffer, *message_buffer;

	DWORD formatte_message = FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER |
        FORMAT_MESSAGE_FROM_SYSTEM |
        FORMAT_MESSAGE_IGNORE_INSERTS,
        NULL,
        GetLastError(),
        0,
        (LPTSTR)&error_buffer,
        0,
        NULL
    );

	if (formatte_message == 0)
		return;

	const TCHAR	*args[2] = {
        original_message,
        error_buffer
    };

    formatte_message = FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER |
        FORMAT_MESSAGE_FROM_STRING |
        FORMAT_MESSAGE_ARGUMENT_ARRAY,
        _T("ERROR: (%1) %2"),
        0,
        0,
        (LPSTR)&message_buffer,
        0,
        (va_list*)&args
    );

    if (formatte_message == 0)
		return;

    MessageBox(NULL, message_buffer, _T("Capslang Exception"), MB_OK | MB_ICONERROR);
}
