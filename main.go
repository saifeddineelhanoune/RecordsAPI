package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Album struct {
	ID     string  `json:"id"`
	Title  string  `json:"title"`
	Artist string  `json:"artist"`
	Price  float64 `json:"price"`
}

var albums = []Album{
	{ID: "1", Title: "Cameleon", Artist: "ElgrandeToto", Price: 25.20},
	{ID: "2", Title: "ByadOuK7al", Artist: "DonBigg", Price: 17.20},
	{ID: "3", Title: "Colors", Artist: "Draganov", Price: 18.50},
}

func GetAlbums(c *gin.Context) {
	c.IndentedJSON(http.StatusOK, albums)
}

func PostAlbums(c *gin.Context) {
	var NewAlbum Album

	if err := c.BindJSON(&NewAlbum); err != nil {
		return 
	}
	albums = append(albums, NewAlbum)
	c.IndentedJSON(http.StatusCreated, NewAlbum)
}



func main() {
	router := gin.Default()
	router.GET("/albums", GetAlbums)
	router.POST("albums", PostAlbums)
	router.Run("localhost:5000")
}
