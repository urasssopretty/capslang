target("capslang")
    set_kind("binary")
    set_installdir("$(projectdir)/build/install")
    
    add_rules("build.mode.params")
    set_values("platform.windows.subsystem", "windows")
    add_syslinks("kernel32", "user32", "gdi32")

    add_files("capslang.cpp")
target_end()

target("caps-mini")
    set_kind("binary")
    set_installdir("$(projectdir)/build/install")

    add_rules("build.mode.params")
    set_values("platform.windows.subsystem", "windows")
    add_syslinks("kernel32", "user32", "gdi32")

    add_files("caps-mini.cpp")
target_end()
