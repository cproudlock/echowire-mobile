package com.fluxer;

import android.content.Intent;

import com.ryanheise.audioservice.AudioServiceActivity;

public abstract class MainActivityBase extends AudioServiceActivity {
    @Override
    protected void onTaskRemoved(Intent rootIntent) {
        onFluxerAppTaskRemoved();
        super.onTaskRemoved(rootIntent);
    }

    protected abstract void onFluxerAppTaskRemoved();
}
