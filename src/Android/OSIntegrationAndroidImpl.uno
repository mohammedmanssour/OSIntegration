using Uno;
using Uno.UX;

using Uno.Compiler.ExportTargetInterop;
using Uno.Compiler.ExportTargetInterop.Android;

namespace MohammedManssour.OneSignal
{

    [Require("Gradle.BuildScript.Repository", "maven { url 'https://plugins.gradle.org/m2/'}")]
    [Require("Gradle.Dependency.ClassPath", "gradle.plugin.com.onesignal:onesignal-gradle-plugin:[0.11.0, 0.99.99]")]
    [Require("Gradle.BuildFile.End", "apply plugin: 'com.onesignal.androidsdk.onesignal-gradle-plugin'")]
    [Require("Gradle.Repository", "maven { url 'https://maven.google.com' }")]
    [Require("Gradle.Dependency.Compile", "com.onesignal:OneSignal:3.9.1")]
    [Require("Gradle.BuildFile.End", "android {defaultConfig {manifestPlaceholders = [onesignal_app_id: '@(Project.OneSignal.Android.AppID)',onesignal_google_project_number: 'REMOTE']}}")]
    [ForeignInclude(Language.Java,
        "com.fuse.Activity",
        "com.onesignal.OneSignal",
        "me.manssourmohammed.onesignal.NotificationReceivedHandler",
        "me.manssourmohammed.onesignal.NotificationOpenedHandler",
        "me.manssourmohammed.onesignal.SubscriptionObserver",
        )]
    public extern(Android) class OSIntegrationAndroidImpl : OSIntegrationImpl
    {

        public OSIntegrationAndroidImpl() : base()
        {

        }

        [Foreign(Language.Java)]
        public override void InitOneSignal()
        @{
            com.uno.UnoObject OSImpl = @{OSIntegrationAndroidImpl:Of(_this)._instance:Get()};

            OneSignal.startInit(Activity.getRootActivity().getApplicationContext())
                .inFocusDisplaying(OneSignal.OSInFocusDisplayOption.Notification)
                .unsubscribeWhenNotificationsAreDisabled(true)
                .setNotificationReceivedHandler(new NotificationReceivedHandler(OSImpl))
                .setNotificationOpenedHandler(new NotificationOpenedHandler(OSImpl))
                .init();


            SubscriptionObserver mSubscriptionObserver = new SubscriptionObserver(OSImpl);
            OneSignal.addSubscriptionObserver(mSubscriptionObserver);
            mSubscriptionObserver.checkSubscriptionStatus();
        @}

        [Foreign(Language.Java), ForeignFixedName]
        public void CallFireRegistrationSucceededEvent(string message)
        @{
            @{OSIntegrationAndroidImpl:Of(_this).FireRegistrationSucceededEvent(string):Call(message)};
        @}

        [Foreign(Language.Java), ForeignFixedName]
        public void CallFireNotificationReceivedEvent(string message)
        @{
            @{OSIntegrationAndroidImpl:Of(_this).FireNotificationReceivedEvent(string):Call(message)};
        @}

        [Foreign(Language.Java), ForeignFixedName]
        public void CallFireNotificationOpenedEvent(string message)
        @{
            @{OSIntegrationAndroidImpl:Of(_this).FireNotificationOpenedEvent(string):Call(message)};
        @}

    }

}