using Uno;
using Uno.UX;

using Uno.Compiler.ExportTargetInterop;

namespace MohammedManssour.OneSignal
{
    [ForeignInclude(Language.Java,"com.onesignal.OneSignal", "com.onesignal.OneSignal.GetTagsHandler", "org.json.JSONObject")]
    public extern(Android) class TagsAndroidImpl : TagsImpl
    {
        [Foreign(Language.Java)]
        public void SendTag(string key, string val)
        @{
            OneSignal.sendTag(key, val);
        @}


        [Foreign(Language.Java)]
        public void DeleteTag(string key)
        @{
            OneSignal.deleteTag(key);
        @}

        [Foreign(Language.Java)]
        public void GetTags(Action<string> Positive, Action<string> Negative)
        @{
            OneSignal.getTags(new GetTagsHandler() {
                @Override
                public void tagsAvailable(JSONObject tags) {
                    Positive.run(tags.toString());
                }
            });
        @}
    }
}