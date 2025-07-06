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

static HHOOK keyboard_hook_handle;

LRESULT CALLBACK keyboard_hook(int nCode, WPARAM wParam, LPARAM lParam);


int APIENTRY WinMain(HINSTANCE hInst, HINSTANCE hInstPrev, LPSTR cmd, int show)
{
    // an event is created to ensure
    // that the program will run in a single instance
    HANDLE hCapsLangEvent = CreateEvent(NULL, TRUE, FALSE, _T("CapsLang"));

    // if event creation fails
    if (hCapsLangEvent == NULL)
    {
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
	if (RegisterHotKey(NULL, EXIT, MOD_CONTROL | MOD_ALT, LETTER_L_KEY) == 0)
    {
        return 1;
    }

    // setup hook to change keyboard layout
	keyboard_hook_handle = SetWindowsHookEx(WH_KEYBOARD_LL, keyboard_hook, GetModuleHandle(0), 0);
	if (keyboard_hook_handle == NULL)
    {
        return 1;
    }

	MSG msg;
	while (GetMessage(&msg, 0, 0, 0))
    {
		TranslateMessage(&msg);
		if(msg.message == WM_HOTKEY && msg.wParam == EXIT)
            PostQuitMessage(0);
		// DispatchMessage(&msg);
	}

	UnhookWindowsHookEx(keyboard_hook_handle);
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

        // if CapsLock is pressed and Shift is NOT pressed
        // then it is necessary to change the keyboard layout language
        if (is_capslock_pressed && !is_shift_pressed)
        {
            INPUT inputs[4] = {0};

            // press Alt
            inputs[0].type = INPUT_KEYBOARD;
            inputs[0].ki.wVk = VK_MENU;

            // press Shift
            inputs[1].type = INPUT_KEYBOARD;
            inputs[1].ki.wVk = VK_SHIFT;

            // release Alt
            inputs[2].type = INPUT_KEYBOARD;
            inputs[2].ki.wVk = VK_MENU;
            inputs[2].ki.dwFlags = KEYEVENTF_KEYUP;

            // release Shift
            inputs[3].type = INPUT_KEYBOARD;
            inputs[3].ki.wVk = VK_SHIFT;
            inputs[3].ki.dwFlags = KEYEVENTF_KEYUP;

            SendInput(4, inputs, sizeof(INPUT));

            // disable behavior of Caps Lock
            return TRUE;
        }
    } while (FALSE);

	return CallNextHookEx(keyboard_hook_handle, nCode, wParam, lParam);
}
