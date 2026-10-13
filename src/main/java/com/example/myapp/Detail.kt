package com.example.myapp

import android.os.Bundle
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class Detail : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_detail)

        val tvResumen = findViewById<TextView>(R.id.tvResumen);
        val btnRegresar = findViewById<TextView>(R.id.btnRegresar);

        val contador = intent.getIntExtra("PASOS", 0);
        tvResumen.text = "PASOS COMPLETADOS: $contador";

        btnRegresar.setOnClickListener{
            finish();
        }
    }
}