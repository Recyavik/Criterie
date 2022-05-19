package main

import (
	"flag"
	"net/http"
	"os"

	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/maxnemoy/review_project/server/server/conf"
	"github.com/maxnemoy/review_project/server/server/db"
	securecheck "github.com/maxnemoy/review_project/server/server/handlers/secureCheck"
	"github.com/maxnemoy/review_project/server/server/handlers/user"
)
func main() {
	port := os.Getenv("PORT")

	if port == "" {
		port = *flag.String("port", "6001", "server port")
	}

	err := godotenv.Load("./.env")

	if err != nil {
		//log.Fatal("Error loading .env file")
	}

	flag.Parse()
	conn := db.Connect()
	apiPublic := echo.New()

	apiPublic.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowMethods: []string{http.MethodGet, http.MethodPut, http.MethodPost, http.MethodDelete, http.MethodPatch},
	}))
	
	apiPublic.Use(middleware.StaticWithConfig(middleware.StaticConfig{
		Root:   os.Getenv("STATIC_FOLDER"),
		Browse: true,
	}))

	apiPublic.Use(middleware.Logger())
	apiPublic.Use(middleware.Recover())

	// Routes
	apiPublic.GET("/", root)
	apiPublic.POST("/user", user.AuthUser(conn))
	apiPublic.PATCH("/user", user.Update(conn))
	apiPublic.PUT("/user", user.CreateUser(conn))

	
	privateZone := apiPublic.Group("/v1")
	conf := middleware.JWTConfig{
		Claims:     &conf.JwtClaims{},
		SigningKey: []byte(os.Getenv("JWT")),
	}
	privateZone.Use(middleware.JWTWithConfig(conf))
	privateZone.GET("/secure", securecheck.SecureCheck(conn))

	apiPublic.Logger.Fatal(apiPublic.Start(":" + port))
}


// Handler
func root(c echo.Context) error {
	return c.String(http.StatusOK, "Project review app")
}