package com.example.findmyage

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*
import java.util.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        buGetAge.setOnClickListener {
              getAge()
        }
    }

    fun getAge() {
        //           Add code run when button click
        val userYearOfBirth = Integer.parseInt(yearTextField.text.toString())
        val currentYear = Calendar.getInstance().get(Calendar.YEAR)

        val userAgeInYears = currentYear - userYearOfBirth

        showAgeTextView.text = "Your age is $userAgeInYears years"

    }
}