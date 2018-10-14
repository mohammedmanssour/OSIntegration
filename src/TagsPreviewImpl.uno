using Uno;
using Uno.UX;
using Uno.Threading;

namespace MohammedManssour.OneSignal
{
    public class TagsPreviewImpl : TagsImpl
    {
        public void SendTag(string key, string val)
        {
            debug_log "This method is not available for this platform";
        }


        public void DeleteTag(string key)
        {
            debug_log "This method is not available for this platform";
        }

        public void GetTags(Action<string> Positive, Action<string> Negative)
        {
            Negative("this promise is not availabe for this platform");
        }
    }
}