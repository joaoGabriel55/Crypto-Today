package com.example.crypto_android_widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import com.example.crypto_android_widget.MainActivity
import com.example.crypto_android_widget.R
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val crypto = widgetData.getString("_cryptoSymbol", null)
                val cryptoValue = widgetData.getString("_cryptoValue", null)
                var cryptoDisplayText = "$crypto value in USD is: $cryptoValue"

                if (cryptoValue == null && crypto == null)
                    cryptoDisplayText = "You have not choosed an crypto currency"

                setTextViewText(R.id.tv_cryptoValue, cryptoDisplayText)

                // Pending intent to update cryptoValue on button click
                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse("myAppWidget://updatecryptovalue")
                )

                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}