//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <agora_rtc_engine/agora_rtc_engine_plugin.h>
#include <flutter_webrtc/flutter_web_r_t_c_plugin.h>
#include <iris_event/iris_event_plugin.h>
#include <permission_handler_windows/permission_handler_windows_plugin.h>
#include <videosdk/videosdk_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AgoraRtcEnginePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AgoraRtcEnginePlugin"));
  FlutterWebRTCPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterWebRTCPlugin"));
  IrisEventPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("IrisEventPlugin"));
  PermissionHandlerWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PermissionHandlerWindowsPlugin"));
  VideosdkPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("VideosdkPluginCApi"));
}
