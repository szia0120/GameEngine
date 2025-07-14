workspace "Engine"
    architecture "x64"
    configurations { "Debug", "Release", "Dist"}

outputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

--include "Engine/vendor/GLFW/"
--include "Engine/vendor/ImGUI/"
--include "Engine/vendor/spdlog"
--include "Engine/vendor/GLAD/"

project "Engine"
    location "Engine"
    kind "SharedLib"
    language "C++"


    targetdir ("bin/" .. outputDir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputDir .. "/%{prj.name}")

    pchheader "pch.h"
    pchsource "%{prj.name}/src/pch.h"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        --"%{prj.name}/vendor/GLAD/include",
        --"%{prj.name}/vendor/GLFW/include",
        --"%{prj.name}/vendor/spdlog/include",
        --"%{prj.name}/vendor/ImGUI",
        "%{prj.name}/src/",
    }

    links 
    {
        --"GLFW",
        --"GLAD"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        buildoptions { "/utf8" }

        defines
        {
            "ENGINE_EXPORTS",
            "ENGINE_PLATFORM_WINDOWS"
        }

        postbuildcommands
        {
            "{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputDir .. "/Sandbox"
        }

    filter "configurations:Debug"
        defines "ENGINE_MODE_DEBUG"
        symbols "On"
    
    filter "configurations:Release"
        defines "ENGINE_MODE_RELEASE"
        optimize "On"
        
    filter "configurations:Dist"
        defines "ENGINE_MODE_DIST"
        optimize "On"


project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"


    targetdir ("bin/" .. outputDir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputDir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/**.h",
        "%{prj.name}/**.cpp"
    }

    includedirs
    {
        "Engine/src/",
        --"Engine/vendor/GLAD/include",
        --"Engine/vendor/GLFW/include",
        --"Engine/vendor/spdlog/include"
    }

    links
    {
        "Engine"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "ENGINE_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "ENGINE_MODE_DEBUG"
        symbols "On"
    
    filter "configurations:Release"
        defines "ENGINE_MODE_RELEASE"
        optimize "On"
        
    filter "configurations:Dist"
        defines "ENGINE_MODE_DIST"
        optimize "On"