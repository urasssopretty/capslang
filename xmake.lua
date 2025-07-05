set_project("CapsLang")
set_version("1.0.0")
set_xmakever("2.8.0")

add_languages("c99")
set_allowedplats("windows")
set_allowedarchs("x64")
set_allowedmodes("release", "debug")

set_policy("run.autobuild",             true)
set_policy("check.auto_ignore_flags",   true)
set_policy("check.auto_map_flags",      true)
set_policy("build.ccache",              true)
set_policy("build.warning",             true)
set_policy("build.optimization.lto",    false)


rule("build.mode.params")
    after_load(function (target)
        if is_mode("release") then
            target:add("defines", "NDEBUG")
            target:add("undefines", "DEBUG")
            target:set("optimize", "fast") -- smallest

            target:set("symbols", "hidden")
            target:set("strip", "all")
            target:set("policy", "preprocessor.linemarkers", true)
        else    -- debug mode
            target:add("defines", "DEBUG")
            target:add("undefines", "NDEBUG")

            target:set("optimize", "none")

            target:set("warnings", "allextra")
            target:set("symbols", "debug")
            target:set("optimize", "none")
        end
    end)
rule_end()


target("capslang")
    set_kind("binary")
    set_installdir("$(projectdir)/build/install")

    add_rules("build.mode.params")
    set_values("platform.windows.subsystem", "windows")
    add_syslinks("kernel32", "user32", "gdi32")

    add_files("src/capslang.c")
target_end()

-- target("caps-mini")
--     set_kind("binary")
--     set_installdir("$(projectdir)/build/install")

--     add_rules("build.mode.params")
--     set_values("platform.windows.subsystem", "windows")
--     add_syslinks("kernel32", "user32", "gdi32")

--     add_files("src/caps-mini.c")
-- target_end()

