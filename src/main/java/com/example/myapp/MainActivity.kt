
package com.example.myapp

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class MainActivity : AppCompatActivity(), SensorEventListener {

    private var contador = 0
    private lateinit var sensorManager: SensorManager
    private lateinit var tvContador: TextView
    private var sensorPasos: Sensor? = null

    // Lista de actividades
    private val actividades = listOf(
        "Pasos Diarios",
        "Natación",
        "Rutina de Fuerza",
        "Sesión de Box",
        "Desayuno",
        "Comida"
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tvContador = findViewById(R.id.tvContador)

        val lista = findViewById<LinearLayout>(
            R.id.listaActividades
        )

        // Crear una fila por cada actividad
        for (nombre in actividades) {

            val fila = LayoutInflater.from(this).inflate(
                R.layout.item_actividad,
                lista,
                false
            )

            val tvNombre = fila.findViewById<TextView>(
                R.id.tvNombreActividad
            )

            val tvEstado = fila.findViewById<TextView>(
                R.id.tvEstadoActividad
            )

            val tvIcono = fila.findViewById<TextView>(
                R.id.tvIconoActividad
            )

            tvNombre.text = nombre

            var completada = false

            // Cambiar el estado al tocar la fila
            fila.setOnClickListener {
                completada = !completada

                if (completada) {
                    fila.setBackgroundColor(
                        Color.rgb(190, 230, 195)
                    )
                    tvEstado.text = "¡Completado!"
                    tvIcono.text = "✓"
                    tvIcono.setTextColor(
                        Color.rgb(35, 140, 65)
                    )
                } else {
                    fila.setBackgroundColor(
                        Color.rgb(240, 240, 240)
                    )
                    tvEstado.text = "Pendiente de completar"
                    tvIcono.text = "○"
                    tvIcono.setTextColor(Color.GRAY)
                }
            }

            // Agregar la fila a la lista
            lista.addView(fila)
        }

        val btnSumar = findViewById<Button>(R.id.btnSumar)
        val btnReiniciar = findViewById<Button>(R.id.btnReiniciar)
        val btnDetalle = findViewById<Button>(R.id.btnDetalle)

        btnSumar.setOnClickListener {
            contador++
            tvContador.text = "Numero de pasos: $contador"
        }

        btnReiniciar.setOnClickListener {
            contador = 0
            tvContador.text = "Numero de pasos: $contador"
        }

        btnDetalle.setOnClickListener {
            val intent = Intent(this, Detail::class.java)
            intent.putExtra("PASOS", contador)
            startActivity(intent)
        }

        // Solicitar permiso del sensor
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.ACTIVITY_RECOGNITION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.ACTIVITY_RECOGNITION),
                100
            )
        } else {
            configurarSensor()
        }
    }

    private fun configurarSensor() {
        sensorManager =
            getSystemService(Context.SENSOR_SERVICE) as SensorManager

        sensorPasos =
            sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER)

        if (sensorPasos == null) {
            tvContador.text = "Sensor de pasos no disponible"
        }
    }

    override fun onResume() {
        super.onResume()

        if (::sensorManager.isInitialized) {
            sensorPasos?.let {
                sensorManager.registerListener(
                    this,
                    it,
                    SensorManager.SENSOR_DELAY_UI
                )
            }
        }
    }

    override fun onPause() {
        super.onPause()

        if (::sensorManager.isInitialized) {
            sensorManager.unregisterListener(this)
        }
    }

    override fun onSensorChanged(event: SensorEvent) {
        if (event.sensor.type == Sensor.TYPE_STEP_COUNTER) {
            val pasosTotales = event.values[0].toInt()
            tvContador.text =
                "Pasos registrados por el sensor: $pasosTotales"
        }
    }

    override fun onAccuracyChanged(
        sensor: Sensor?,
        accuracy: Int
    ) {
        // No necesitamos hacer nada aqui
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(
            requestCode,
            permissions,
            grantResults
        )

        if (requestCode == 100) {
            if (grantResults.isNotEmpty() &&
                grantResults[0] == PackageManager.PERMISSION_GRANTED
            ) {
                configurarSensor()
            } else {
                tvContador.text = "Permiso del sensor no concedido"
            }
        }
    }
}
