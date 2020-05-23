
#ifdef _WIN32
#  ifdef DLL_PUBLIC_EXPORTS
#    define DLL_PUBLIC __declspec(dllexport)
#  else
#    define DLL_PUBLIC __declspec(dllimport)
#  endif
#else
#  define DLL_PUBLIC __attribute__ ((visibility ("default")))
#endif

DLL_PUBLIC const char *token(void);
