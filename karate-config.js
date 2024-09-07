function fn(){
    karate.configure('connectTimeout', 5000)
    karate.configure('readTimeout', 5000)

    return {
        api: {
            baseurl: "https://petstore.swagger.io/v2/"
        }
    }
}
