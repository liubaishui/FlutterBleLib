#import "FlutterBleLibPlugin.h"
#import "ArgumentKey.h"
#import "ChannelName.h"
#import "MethodName.h"
#import "AdapterStateStreamHandler.h"
#import "RestoreStateStreamHandler.h"
#import "ScanningStreamHandler.h"
#import "ConnectionStateStreamHandler.h"
#import "MonitorCharacteristicStreamHandler.h"
#import "ArgumentHandler.h"
#import "FlutterErrorFactory.h"
#import "CommonTypes.h"
#import "CharacteristicResponseConverter.h"
#import "PeripheralResponseConverter.h"
#import "DescriptorResponseConverter.h"
#import "ServiceResponseConverter.h"


@interface FlutterBleLibPlugin ()

@property (nonatomic) AdapterStateStreamHandler *adapterStateStreamHandler;
@property (nonatomic) RestoreStateStreamHandler *restoreStateStreamHandler;
@property (nonatomic) ScanningStreamHandler *scanningStreamHandler;
@property (nonatomic) ConnectionStateStreamHandler *connectionStateStreamHandler;
@property (nonatomic) MonitorCharacteristicStreamHandler *monitorCharacteristicStreamHandler;

@end

@implementation FlutterBleLibPlugin

// MARK: - Initializers

- (instancetype)init {
    self = [super init];
    if (self) {
        self.adapterStateStreamHandler = [AdapterStateStreamHandler new];
        self.restoreStateStreamHandler = [RestoreStateStreamHandler new];
        self.scanningStreamHandler = [ScanningStreamHandler new];
        self.connectionStateStreamHandler = [ConnectionStateStreamHandler new];
        self.monitorCharacteristicStreamHandler = [MonitorCharacteristicStreamHandler new];
    }
    return self;
}

// MARK: - FlutterPlugin implementation

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:CHANNEL_NAME_FLUTTER_BLE_LIB binaryMessenger:[registrar messenger]];

    FlutterEventChannel *adapterStateChannel = [FlutterEventChannel eventChannelWithName:CHANNEL_NAME_ADAPTER_STATE_CHANGES binaryMessenger:[registrar messenger]];
    FlutterEventChannel *restoreStateChannel = [FlutterEventChannel eventChannelWithName:CHANNEL_NAME_STATE_RESTORE_EVENTS binaryMessenger:[registrar messenger]];
    FlutterEventChannel *scanningChannel = [FlutterEventChannel eventChannelWithName:CHANNEL_NAME_SCANNING_EVENTS binaryMessenger:[registrar messenger]];
    FlutterEventChannel *connectionStateChannel = [FlutterEventChannel eventChannelWithName:CHANNEL_NAME_CONNECTION_STATE_CHANGE_EVENTS binaryMessenger:[registrar messenger]];
    FlutterEventChannel *monitorCharacteristicChannel = [FlutterEventChannel eventChannelWithName:CHANNEL_NAME_MONITOR_CHARACTERISTIC binaryMessenger:[registrar messenger]];

    FlutterBleLibPlugin *instance = [[FlutterBleLibPlugin alloc] init];
    
    [registrar addMethodCallDelegate:instance channel:channel];

    [adapterStateChannel setStreamHandler:instance.adapterStateStreamHandler];
    [restoreStateChannel setStreamHandler:instance.restoreStateStreamHandler];
    [scanningChannel setStreamHandler:instance.scanningStreamHandler];
    [connectionStateChannel setStreamHandler:instance.connectionStateStreamHandler];
    [monitorCharacteristicChannel setStreamHandler:instance.monitorCharacteristicStreamHandler];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    result(FlutterMethodNotImplemented);
}


@end
