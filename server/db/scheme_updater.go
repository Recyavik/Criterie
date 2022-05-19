package db

import (
	"github.com/go-pg/pg/v10"
	"github.com/go-pg/pg/v10/orm"
	"github.com/maxnemoy/review_project/server/server/db/models"
)

func createSchema(db *pg.DB) error {
	for _, model := range []interface{}{
		(*models.User)(nil),
	} {
		err := db.Model(model).CreateTable(&orm.CreateTableOptions{IfNotExists: true})
		if err != nil {
			return err
		}
	}
	return nil
}