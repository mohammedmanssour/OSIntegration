using Uno;
using Uno.UX;

namespace MohammedManssour.OneSignal
{

    public class OSIntegrationPreviewImpl : OSIntegrationImpl
    {

        public override void InitOneSignal()
        {
            debug_log "OneSignal is not available on this platform";
        }

    }

}