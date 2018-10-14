package me.manssourmohammed.onesignal;

import com.onesignal.OSNotification;
import com.onesignal.OneSignal;
import com.uno.UnoObject;
import com.foreign.MohammedManssour.OneSignal.OSIntegrationAndroidImpl;

/**
 * Created by mhdmansour on 3/21/18.
 */

public class NotificationReceivedHandler implements OneSignal.NotificationReceivedHandler {

    public UnoObject OSImpl;

    public NotificationReceivedHandler(UnoObject OSImpl)
    {
        this.OSImpl = OSImpl;
    }

    @Override
    public void notificationReceived(OSNotification notification) {
        OSIntegrationAndroidImpl.CallFireNotificationReceivedEvent(this.OSImpl, notification.toJSONObject().toString());
    }
}
