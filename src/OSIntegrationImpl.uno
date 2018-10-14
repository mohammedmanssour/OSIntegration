using Uno;
using Uno.UX;
using Uno.Collections;
using Fuse.Scripting;
using Fuse.Platform;
using Uno.Compiler.ExportTargetInterop;
using Uno.Compiler.ExportTargetInterop.Android;

namespace MohammedManssour.OneSignal{

    public abstract class OSIntegrationImpl {

        public OSIntegrationImpl _instance;

        public event EventHandler<string> OnNotificationReceived;
        public event EventHandler<string> OnNotificationOpened;
        public event EventHandler<string> RegistrationSucceeded;

        public List<string> _cachedMessages = new List<string>();

        bool _init = false;

        public OSIntegrationImpl()
        {
            _instance = this;
        }

        public object Register()
        {
            if(_init)
                return null;

            _init = true;
            InitOneSignal();

            Lifecycle.EnteringInteractive += OnEneringInteractive;

            return null;
        }

        public void FireNotificationReceivedEvent(string message)
        {
            if(Lifecycle.State == ApplicationState.Interactive)
            {
                var x = OnNotificationReceived;
                if(x != null){
                    x(null, message);
                }
            }
            else
            {
                _cachedMessages.Add(message);
            }
        }


        public void FireNotificationOpenedEvent(string message)
        {
            var x = OnNotificationOpened;
            if(x != null)
                x(null, message);
        }


        public void FireRegistrationSucceededEvent(string message)
        {
            var x = RegistrationSucceeded;
            if(x != null)
                x(null, message);
        }

        public void OnEneringInteractive(ApplicationState newState)
        {
            var x = OnNotificationReceived;
            if( x != null && _cachedMessages.Count > 0){
                foreach(var message in _cachedMessages)
                {
                    x(null, message);
                }
            }
            _cachedMessages.Clear();
        }


        abstract public void InitOneSignal();

    }

}