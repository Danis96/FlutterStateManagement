package com.example.zooapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.content.Context
import android.content.Intent
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.animal_card.view.*


class MainActivity : AppCompatActivity() {

    var listOfAnimals = arrayListOf<Animal>()
    var adapter: AnimalsAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

//        load animals
        listOfAnimals.add(
            Animal(
                "Lion",
                "Lion is the most dangerous cat on the world.",
                R.drawable.lion,
                true,
            )
        )
        listOfAnimals.add(
            Animal(
                "Whale",
                "Whale killer is black and white. Rare ones are albino",
                R.drawable.whale,
                true,
            )
        )
        listOfAnimals.add(Animal("Bird", "Bird can fly, they are so lucky", R.drawable.bird, false))
        listOfAnimals.add(
            Animal(
                "Elephant",
                "Smartest and most memorizable animal",
                R.drawable.elephant,
                false
            )
        )
        listOfAnimals.add(
            Animal(
                "Panda",
                "Panda is the type of bear from east countries. And it knows Kun-fu",
                R.drawable.panda,
                false
            )
        )
        listOfAnimals.add(
            Animal(
                "Wolf",
                "Wolf is just a big dog. Nothing to fear",
                R.drawable.wolf,
                true
            )
        )

        adapter = AnimalsAdapter(this, listOfAnimals)
        listAnimal.adapter = adapter
    }

    fun delete(index: Int) {
        listOfAnimals.removeAt(index)
        adapter!!.notifyDataSetChanged()
    }

    fun add(index: Int) {
        listOfAnimals.add(index, listOfAnimals[index])
        adapter!!.notifyDataSetChanged()
    }

   inner class AnimalsAdapter : BaseAdapter {

        var listOfAnimals = arrayListOf<Animal>()
        var context: Context? = null

        constructor(context: Context, listOfAnimals: ArrayList<Animal>) : super() {
            this.listOfAnimals = listOfAnimals
            this.context = context
        }

        //        how many elements I have in listView
        override fun getCount(): Int {
            return listOfAnimals.size
        }

        override fun getItem(index: Int): Any {
            return listOfAnimals[index]
        }

        override fun getItemId(position: Int): Long {
            return position.toLong()
        }

        //        this method will call *times that is size or itemCount
        override fun getView(index: Int, convertView: View?, parent: ViewGroup?): View {

            val animal = listOfAnimals[index]
            if (animal.isKiller == true) {
                var inflator =
                    context!!.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
                var myView = inflator.inflate(R.layout.animal_killer_card, null)
                myView.tvName.text = animal.name!!
                myView.tvDescription.text = animal.description!!
                myView.imgName.setImageResource(animal.image!!)
                myView.setOnClickListener {
                    val intent = Intent(context, AnimalDetails::class.java)
                    intent.putExtra("name", animal.name!!)
                    intent.putExtra("desc", animal.description!!)
                    intent.putExtra("image", animal.image!!)
                    context!!.startActivity(intent)
                }
                return myView
            } else {
                var inflator =
                    context!!.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
                var myView = inflator.inflate(R.layout.animal_card, null)
                myView.tvName.text = animal.name!!
                myView.tvDescription.text = animal.description!!
                myView.imgName.setImageResource(animal.image!!)
                myView.imgName.setOnClickListener {
                    val intent = Intent(context, AnimalDetails::class.java)
                    intent.putExtra("name", animal.name!!)
                    intent.putExtra("desc", animal.description!!)
                    intent.putExtra("image", animal.image!!)
                    context!!.startActivity(intent)
                }
                return myView
            }


        }

    }

}