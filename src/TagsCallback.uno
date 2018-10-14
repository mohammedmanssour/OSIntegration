using Uno;
using Uno.Threading;

namespace MohammedManssour.OneSignal
{

    public class TagsCallback
    {

        public Promise<string> _promise;

        public Action<string> Positive;
		public Action<string> Negative;

        public TagsCallback(Promise<string> _promise)
        {
            this._promise = _promise;

            Positive = (str) => _promise.Resolve(str);
            Negative = (str) => _promise.Reject(new Exception(str));
        }

    }

}