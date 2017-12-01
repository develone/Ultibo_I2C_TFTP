program I2C_TFTP;

{$mode objfpc}{$H+}

{ Advanced example -  I2C_TFTP                                             }
{                                                                         }
{ This example shows how to create  webserver and TFTP server with remote shell  }
{ This version is for Raspberry Pi 2B and will also work on a 3B.                }

{ After the first time that kernel7.img has been transferred to micro sd card    }
{ tftp xx.xx.xx.xx < cmdstftp                                                    }
{ contents of cmdstftp                                                           }
{ binary                                                                         }
{ put kernel7.img                                                                }
{ quit                                                                           }

uses
  InitUnit,     {Include InitUnit to allow us to change the startup behaviour}
  RaspberryPi2, {Include RaspberryPi2 to make sure all standard functions are included}
  GlobalConst,
  GlobalTypes,
  Threads,
  Console,
  HTTP,         {Include HTTP and WebStatus so we can see from a web browser what is happening}
  WebStatus,


  uTFTP,
  Winsock2,
  { needed to use ultibo-tftp  }
  { needed for telnet }
      Shell,
     ShellFilesystem,
     ShellUpdate,
     RemoteShell,
  { needed for telnet }
GlobalConfig,
  SysUtils,
  Logging,
  I2C;
var
 LeftWindow:TWindowHandle;
 HTTPListener:THTTPListener;
 { needed to use ultibo-tftp  }
 TCP : TWinsock2TCPClient;
 IPAddress : string;
 //PI2CDevice : ^TI2CDevice;
 MYI2C : PI2CDevice;

begin


 {Create a console window to show what is happening}
 LeftWindow:=ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_LEFT,True);

 {Display a startup message on the console}
 ConsoleWindowWriteLn(LeftWindow,'Starting I2C_TFTP example');

 ConsoleWindowWriteLn(LeftWindow,'Enable Logging');
 CONSOLE_REGISTER_LOGGING:=True;
 LoggingConsoleDeviceAdd(ConsoleDeviceGetDefault);
 LoggingDeviceSetDefault(LoggingDeviceFindByType(LOGGING_TYPE_CONSOLE));

 {Create and start the HTTP Listener for our web status page}
 HTTPListener:=THTTPListener.Create;
 HTTPListener.Active:=True;

 {Register the web status page, the "Thread List" page will allow us to see what is happening in the example}
 WebStatusRegister(HTTPListener,'','',True);

 MYI2C:=PI2CDevice(I2CDeviceFindByDescription('BCM2836 BSC0 Master I2C'));
 ConsoleWindowWriteLn(LeftWindow,'MYI2C ' + inttostr(sizeof(MYI2C)));
 while True do
  begin
   //ConsoleWindowWriteLn(LeftWindow,'Starting I2C_TFTP example');
  end;
 {Halt this thread}
 ThreadHalt(0);
end.

