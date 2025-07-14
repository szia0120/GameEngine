#pragma once


#ifdef ENGINE_PLATFORM_WINDOWS
	#ifdef ENGINE_EXPORTS
		#define ENGINE_API _declspec(dllexport)
	#elif defined ENGINE_IMPORTS
		#define ENGINE_API _declspec(dllexport)
	#endif
#endif


#define ENGINE_VERSION	"0.0.1"