package com.example.zooapp

class Animal {

    var name: String? = null
    var description: String? = null
    var image: Int? = null
    var isKiller: Boolean? = false

    constructor(name: String, description: String, image: Int, isKiller: Boolean) {
        this.description = description
        this.image = image
        this.name = name
        this.isKiller = isKiller
    }

}