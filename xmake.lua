set_project("Capslang")
set_version("0.0.1")
set_xmakever("2.8.0")

add_languages("cxx23", "c23")
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


includes("src")
