package me.manssourmohammed.onesignal;

import com.onesignal.OSNotificationOpenResult;
import com.onesignal.OneSignal;
import com.uno.UnoObject;

import com.foreign.MohammedManssour.OneSignal.OSIntegrationAndroidImpl;

/**
 * Created by mhdmansour on 3/21/18.
 */

public class NotificationOpenedHandler implements OneSignal.NotificationOpenedHandler {

	public UnoObject OSImpl;

	public NotificationOpenedHandler(UnoObject OSImpl)
	{
		this.OSImpl = OSImpl;
	}

	@Override
	public void notificationOpened(OSNotificationOpenResult result) {
		OSIntegrationAndroidImpl.CallFireNotificationOpenedEvent(this.OSImpl, result.toJSONObject().toString());
	}
}
