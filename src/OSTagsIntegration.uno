using Uno;
using Uno.UX;
using Uno.Threading;

using Fuse.Scripting;

namespace MohammedManssour.OneSignal
{
    public class OSTagsIntegration
    {

        public TagsImpl OSTagsImpl;

        public OSTagsIntegration()
        {
            OSTagsImpl = GetTheRightImplementation();
        }

        public object SendTag(Context context, object[] args)
        {
            string key = args.ValueOrDefault(0, "");
            string val = args.ValueOrDefault(1, "");

            OSTagsImpl.SendTag(key, val);
            return null;
        }

        public object DeleteTag(Context context, object[] args)
        {
            string key = args.ValueOrDefault(0, "");

            OSTagsImpl.DeleteTag(key);
            return null;
        }

        public Future<string> GetTags(object[] args)
        {
            Promise<string> promise = new Promise<string>();
            var cb = new TagsCallback(promise);

            OSTagsImpl.GetTags(cb.Positive, cb.Negative);

            return promise;
        }

        public TagsImpl GetTheRightImplementation()
        {
            if defined(ANDROID)
                return new TagsAndroidImpl();
            return new TagsPreviewImpl();
        }

    }
}