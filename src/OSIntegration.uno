using Uno;
using Uno.UX;

using Fuse;
using Fuse.Scripting;

namespace MohammedManssour.OneSignal
{
    [UXGlobalModule]
    public class OSIntegration : NativeEventEmitterModule
    {
        public static readonly OSIntegration _instance;

        public OSIntegration()
                :base(true, "registrationSucceeded", "notificationOpened", "notificationReceived")
        {
            if(_instance != null) return;

            _instance = this;

            Uno.UX.Resource.SetGlobalKey(this, "OneSignal");

            // start backward compability
            NativeEvent NotificationReceived = new NativeEvent("OnNotificationReceived");
            NativeEvent NotificationOpened = new NativeEvent("OnNotificationOpened");
            NativeEvent RegistrationSucceeded = new NativeEvent("OnRegistrationSucceeded");

            On("notificationReceived", NotificationReceived);
            On("notificationOpened", NotificationOpened);
            On("registrationSucceeded", RegistrationSucceeded);
            // end backward compability

            OSIntegrationImpl OSImpl = GetOSIntegrationImplementation();
            OSImpl.OnNotificationReceived += FireNotificationReceived;
            OSImpl.OnNotificationOpened += FireNotificationOpened;
            OSImpl.RegistrationSucceeded += FireRegistrationSucceeded;

            OSImpl.Register();

            //tags section
            OSTagsIntegration OSTags = new OSTagsIntegration();
            AddMember(new NativeFunction("sendTag", (NativeCallback)OSTags.SendTag));
            AddMember(new NativeFunction("deleteTag", (NativeCallback)OSTags.DeleteTag));

            AddMember(new NativePromise<string,Fuse.Scripting.Object>("getTags", OSTags.GetTags));
        }

        public void FireNotificationReceived(object sender, string message)
        {
            Emit("notificationReceived", message);
        }

        public void FireNotificationOpened(object sender, string message)
        {
            Emit("notificationOpened", message);
        }

        public void FireRegistrationSucceeded(object sender, string message)
        {
            Emit("registrationSucceeded", message);
        }

        public OSIntegrationImpl GetOSIntegrationImplementation()
        {
            if defined(ANDROID)
                return new OSIntegrationAndroidImpl();

            return new OSIntegrationPreviewImpl();
        }
    }

}
