project "OptickCore"
	uuid "830934D9-6F6C-C37D-18F2-FB3304348F00"
	cppdialect "C++11"
	systemversion "latest"
 	kind "SharedLib"
 	
 	buildoptions { 
		"/wd4127", -- Conditional expression is constant
		"/wd4091"  -- 'typedef ': ignored on left of '' when no variable is declared
	}
	flags { "NoManifest", "FatalWarnings" }
	warnings "Extra"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	LibraryDir["optick"] = LibraryDir["optick"] .. "/bin/" .. outputdir .. "/OptickCore"
	Library["optick"] = "%{LibraryDir.optick}/OptickCore.lib"
	Library["optickDLL"] = "%{LibraryDir.optick}/OptickCore.dll"

	includedirs
	{
		"src"
	}
	
	defines 
	{ 
		"OPTICK_ENABLE_GPU_D3D12=0",
		"_CRT_SECURE_NO_WARNINGS",
		"OPTICK_LIB=1",
		"OPTICK_EXPORTS",
		"USE_OPTICK=1",
	}

	includedirs
	{
		"%{IncludeDir.VulkanSDK}",
	}
	libdirs {
		"%{LibraryDir.VulkanSDK}",
	}
	links { 
		"%{Library.Vulkan}",
	}
	
	files {
		"src/**.cpp",
        "src/**.h", 
	}
	vpaths {
		["api"] = { 
			"src/optick.h",
			"src/optick.config.h",
		},
	}
	
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		defines { "_DEBUG", "_CRTDBG_MAP_ALLOC", "MT_INSTRUMENTED_BUILD" }

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "configurations:Profile"
		runtime "Release"
		optimize "on"