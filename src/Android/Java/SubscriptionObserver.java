package me.manssourmohammed.onesignal;

import android.app.Activity;
import android.util.Log;
import java.lang.Object;

import com.onesignal.OSPermissionSubscriptionState;
import com.onesignal.OSSubscriptionObserver;
import com.onesignal.OSSubscriptionState;
import com.onesignal.OSSubscriptionStateChanges;
import com.onesignal.OneSignal;
import com.uno.UnoObject;

import org.json.JSONException;
import org.json.JSONObject;
import com.foreign.MohammedManssour.OneSignal.OSIntegrationAndroidImpl;

/**
 * Created by mhdmansour on 3/19/18.
 */

public class SubscriptionObserver implements OSSubscriptionObserver {

    public UnoObject OSImpl;

    public SubscriptionObserver(UnoObject OSImpl)
    {
        this.OSImpl = OSImpl;
    }

    public OSSubscriptionState getSubscriptionStatus() {
        OSPermissionSubscriptionState status = OneSignal.getPermissionSubscriptionState();
        return status.getSubscriptionStatus();
    }

    public void checkSubscriptionStatus() {
        android.util.Log.d("SubscriptionObserver", "checking subscription status 1");
        OSSubscriptionState subscriptionStatus = getSubscriptionStatus();

        if (subscriptionStatus.getSubscribed() && !subscriptionStatus.getPushToken().isEmpty()
                && !subscriptionStatus.getUserId().isEmpty()) {
            // call androidImple staticly
            String info = subscriptionStatus.toJSONObject().toString();

            android.util.Log.d("SubscriptionObserver", "checking subscription status");
            // call event here
            OSIntegrationAndroidImpl.CallFireRegistrationSucceededEvent(this.OSImpl, info);
        }

    }

    @Override
    public void onOSSubscriptionChanged(OSSubscriptionStateChanges stateChanges) {
        if (!stateChanges.getFrom().getSubscribed() && stateChanges.getTo().getSubscribed()) {
            String info = stateChanges.getTo().toJSONObject().toString();

            android.util.Log.d("SubscriptionObserver", "subscription status changed");
            //call event here
            OSIntegrationAndroidImpl.CallFireRegistrationSucceededEvent(this.OSImpl, info);


        } else {
            checkSubscriptionStatus();
        }
    }
}
