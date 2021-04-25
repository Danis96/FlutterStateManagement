package com.example.zooapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_animal_details.*

class AnimalDetails : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_animal_details)

        val bundle:Bundle = intent.extras!!
        val name = bundle.getString("name")
        val desc = bundle.getString("desc")
        val image = bundle.getInt("image")
        imgDetailsImage.setImageResource(image)
        tvDetailsName.text = name
        tvDetailsDescription.text = desc
    }
}