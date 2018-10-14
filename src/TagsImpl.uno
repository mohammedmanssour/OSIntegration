using Uno;
using Uno.UX;
using Uno.Threading;

namespace MohammedManssour.OneSignal
{

    public interface TagsImpl
    {

        void SendTag(string key, string val);

        void DeleteTag(string key);

        void GetTags(Action<string> Positive, Action<string> Negative);

    }

}