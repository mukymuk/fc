#include "slick.sh"

_command st_util() name_info(','VSARG2_MACRO|VSARG2_MARK|VSARG2_REQUIRES_MDI_EDITORCTL)
{
   int r= shell("c:\\cygwin\\bin\\bash.exe -c ./debug.sh",'A');
   //"file=C:/cygwin/home/Shawn/stm/fc/build/Debug/fc.elf,host=localhost,port=4242,timeout=4,address=32,cache=1,break=1,path=C:\\cygwin\\opt\\4.9-2014q4\\bin\\arm-none-eabi-gdb.exe,args=,session=WORKSPACE: C:\\cygwin\\home\\Shawn\\stm\\se\\fc\\fc.vpw"
   debug_remote();
}
