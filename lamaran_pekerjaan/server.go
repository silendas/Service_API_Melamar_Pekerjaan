package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

type Admin struct {
	Id_Admin uint   `json:"id_admin"`
	Nama     string `json:"nama"`
	Username string `json:"username"`
	Pass     string `json:"password"`
}

type HRD struct {
	Id_HRD uint   `json:"id_hrd"`
	Nama   string `json:"nama"`
	Cabang string `json:"cabang"`
	Nohp   string `json:"nohp"`
	Email  string `json:"email"`
	Pass   string `json:"password"`
}

type Pelamar struct {
	Id_Pelamar uint   `json:"id_pelamar"`
	Nik        string `json:"nik"`
	Nama       string `json:"nama"`
	Jk         string `json:"jk"`
	Tgl_Lahir  string `json:"tgl_lhr"`
	Nohp       string `json:"nohp"`
	Alamat     string `json:"alamat"`
	Email      string `json:"email"`
	Pass       string `json:"password"`
	Tgl_Daftar string `json:"tgl_dftr"`
}

type Pendidikan struct {
	Id_Pendidikan uint   `json:"id_pendidikan"`
	Id_Pelamar    string `json:"id_pelamar"`
	Sekolah       string `json:"sekolah"`
	Jurusan       string `json:"jurusan"`
	Nilai         string `json:"nilai"`
	Thn_Lulus     string `json:"thn_lulus"`
}

type Pengalaman struct {
	Id_Pengalaman uint   `json:"id_pengalaman"`
	Id_Pelamar    uint   `json:"id_pelamar"`
	Perusahaan    string `json:"perusahaan"`
	Posisi        string `json:"posisi"`
	F_Date        string `json:"f_date"`
	L_Date        string `json:"l_date"`
	Deskripsi     string `json:"deskrpsi"`
}

type Loker struct {
	Id_Loker    uint   `json:"id_loker"`
	Posisi      string `json:"posisi"`
	Cabang      string `json:"cabang"`
	Deskripsi   string `json:"deskripsi"`
	Gaji        string `json:"gaji"`
	Status      string `json:"status"`
	Tgl_Publish string `json:"tgl_pblsh"`
}

type Melamar struct {
	Id_Melamar  uint   `json:"id_melamar"`
	Id_Loker    uint   `json:"id_loker"`
	Id_Pelamar  uint   `json:"id_pelamar"`
	Nik         string `json:"nik"`
	Nama        string `json:"nama"`
	Posisi      string `json:"posisi"`
	Cabang      string `json:"cabang"`
	Kualifikasi string `json:"kualifikasi"`
	Nilai       string `json:"nilai_tst"`
	Tgl         string `json:"tgl_melamar"`
}

type H_Melamar struct {
	Id_histori  uint   `json:"id_histori"`
	Nik         string `json:"nik"`
	Nama        string `json:"nama"`
	Posisi      string `json:"posisi"`
	Cabang      string `json:"cabang"`
	Kualifikasi string `json:"kualifikasi"`
	Nilai_Tst   string `json:"nilai_tst"`
	Aksi        string `json:"aksi"`
	Tgl         string `json:"tgl_histori"`
}

type Test struct {
	Id_test    uint   `json:"id_test"`
	Pertanyaan string `json:"pertanyaan"`
	J_a        string `json:"a"`
	J_b        string `json:"b"`
	J_c        string `json:"c"`
	Jawaban    string `json:"jawaban"`
	Posisi     string `json:"posisi"`
}

type Cabang struct {
	Cabang string `json:"l_cabang"`
}

type Posisi struct {
	Posisi string `json:"l_posisi"`
}

func main() {

	// database connection
	db, err := sql.Open("mysql", "root:@tcp(127.0.0.1:3306)/db_pekerjaan")
	defer db.Close()

	if err != nil {
		log.Fatal(err)
	}
	// database connection

	e := echo.New()

	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowHeaders: []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept},
	}))

	// Test API
	e.GET("/api", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, Service API!")
	})
	// Test API

	// Admin
	e.GET("/api/admin/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_admin")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var admin []Admin
		for res.Next() {
			var m Admin
			_ = res.Scan(&m.Id_Admin, &m.Nama, &m.Username, &m.Pass)
			admin = append(admin, m)
		}

		return c.JSON(http.StatusOK, admin)
	})

	e.GET("/api/admin/login/:username/:pass", func(c echo.Context) error {
		sqlStatement := "CALL spl_admin(?,?)"
		res, err := db.Query(sqlStatement, c.Param("username"), c.Param("pass"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var admin []Admin
		for res.Next() {
			var m Admin
			_ = res.Scan(&m.Id_Admin, &m.Nama, &m.Username, &m.Pass)
			admin = append(admin, m)
		}

		return c.JSON(http.StatusOK, admin)
	})

	e.GET("/api/admin/get/:nama", func(c echo.Context) error {
		sqlStatement := "CALL sp_admin(?)"
		res, err := db.Query(sqlStatement, c.Param("nama"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var admin []Admin
		for res.Next() {
			var m Admin
			_ = res.Scan(&m.Id_Admin, &m.Nama, &m.Username, &m.Pass)
			admin = append(admin, m)
		}

		return c.JSON(http.StatusOK, admin)
	})

	e.POST("/api/admin/post/:nama/:username/:pass", func(c echo.Context) error {
		var admin Admin
		c.Bind(&admin)

		sqlStatement := "CALL i_admin(?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("nama"), c.Param("username"), c.Param("pass"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, admin)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/admin/put/:id/:nama/:username/:pass", func(c echo.Context) error {
		var admin Admin
		c.Bind(&admin)

		sqlStatement := "CALL u_admin(?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), c.Param("nama"), c.Param("username"), c.Param("pass"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, admin)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.DELETE("/api/admin/delete/:id", func(c echo.Context) error {
		var admin Admin
		c.Bind(&admin)

		sqlStatement := "CALL d_admin(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, admin)
		}
		return c.String(http.StatusOK, "ok")
	})
	// Admin

	// HRD
	e.GET("/api/hrd/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_hrd")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var hrd []HRD
		for res.Next() {
			var m HRD
			_ = res.Scan(&m.Id_HRD, &m.Nama, &m.Cabang, &m.Nohp, &m.Email, &m.Pass)
			hrd = append(hrd, m)
		}

		return c.JSON(http.StatusOK, hrd)
	})

	e.GET("/api/hrd/login/:email/:pass", func(c echo.Context) error {
		sqlStatement := "CALL spl_hrd(?,?)"
		res, err := db.Query(sqlStatement, c.Param("email"), c.Param("pass"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var hrd []HRD
		for res.Next() {
			var m HRD
			_ = res.Scan(&m.Id_HRD, &m.Nama, &m.Cabang, &m.Nohp, &m.Email, &m.Pass)
			hrd = append(hrd, m)
		}

		return c.JSON(http.StatusOK, hrd)
	})

	e.GET("/api/hrd/get/:id", func(c echo.Context) error {
		sqlStatement := "CALL sp_hrd(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var hrd []HRD
		for res.Next() {
			var m HRD
			_ = res.Scan(&m.Id_HRD, &m.Nama, &m.Cabang, &m.Nohp, &m.Email, &m.Pass)
			hrd = append(hrd, m)
		}

		return c.JSON(http.StatusOK, hrd)
	})

	e.GET("/api/hrd/get/nama/:nama", func(c echo.Context) error {
		sqlStatement := "CALL spn_hrd(?)"
		res, err := db.Query(sqlStatement, c.Param("nama"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var hrd []HRD
		for res.Next() {
			var m HRD
			_ = res.Scan(&m.Id_HRD, &m.Nama, &m.Cabang, &m.Nohp, &m.Email, &m.Pass)
			hrd = append(hrd, m)
		}

		return c.JSON(http.StatusOK, hrd)
	})

	e.POST("/api/hrd/post/:nama/:cabang/:nohp/:email/:pass", func(c echo.Context) error {
		var hrd HRD
		c.Bind(&hrd)

		sqlStatement := "CALL i_hrd(?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("nama"), c.Param("cabang"), c.Param("nohp"), c.Param("email"), c.Param("pass"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, hrd)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/hrd/put/:id/:nama/:cabang/:nohp/:email/:pass", func(c echo.Context) error {
		var hrd HRD
		c.Bind(&hrd)

		sqlStatement := "CALL u_hrd(?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), c.Param("nama"), c.Param("cabang"), c.Param("nohp"), c.Param("email"), c.Param("pass"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, hrd)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.DELETE("/api/hrd/delete/:id", func(c echo.Context) error {
		var hrd HRD
		c.Bind(&hrd)

		sqlStatement := "CALL d_hrd(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, hrd)
		}
		return c.String(http.StatusOK, "ok")
	})
	// HRD

	// Pelamar
	e.GET("/api/pelamar/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_pelamar")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var pelamar []Pelamar
		for res.Next() {
			var m Pelamar
			_ = res.Scan(&m.Id_Pelamar, &m.Nik, &m.Nama, &m.Jk, &m.Tgl_Lahir, &m.Nohp, &m.Alamat, &m.Email, &m.Pass, &m.Tgl_Daftar)
			pelamar = append(pelamar, m)
		}

		return c.JSON(http.StatusOK, pelamar)
	})

	e.GET("/api/pelamar/login/:email/:pass", func(c echo.Context) error {
		sqlStatement := "CALL spl_pelamar(?,?)"
		res, err := db.Query(sqlStatement, c.Param("email"), c.Param("pass"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var pelamar []Pelamar
		for res.Next() {
			var m Pelamar
			_ = res.Scan(&m.Id_Pelamar, &m.Nik, &m.Nama, &m.Jk, &m.Tgl_Lahir, &m.Nohp, &m.Alamat, &m.Email, &m.Pass, &m.Tgl_Daftar)
			pelamar = append(pelamar, m)
		}

		return c.JSON(http.StatusOK, pelamar)
	})

	e.GET("/api/pelamar/get/:nik", func(c echo.Context) error {
		sqlStatement := "CALL sp_pelamar(?)"
		res, err := db.Query(sqlStatement, c.Param("nik"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var pelamar []Pelamar
		for res.Next() {
			var m Pelamar
			_ = res.Scan(&m.Id_Pelamar, &m.Nik, &m.Nama, &m.Jk, &m.Tgl_Lahir, &m.Nohp, &m.Alamat, &m.Email, &m.Pass, &m.Tgl_Daftar)
			pelamar = append(pelamar, m)
		}

		return c.JSON(http.StatusOK, pelamar)
	})

	e.GET("/api/pelamar/get/id/:id", func(c echo.Context) error {
		sqlStatement := "CALL spi_pelamar(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var pelamar []Pelamar
		for res.Next() {
			var m Pelamar
			_ = res.Scan(&m.Id_Pelamar, &m.Nik, &m.Nama, &m.Jk, &m.Tgl_Lahir, &m.Nohp, &m.Alamat, &m.Email, &m.Pass, &m.Tgl_Daftar)
			pelamar = append(pelamar, m)
		}

		return c.JSON(http.StatusOK, pelamar)
	})

	e.POST("/api/pelamar/post/:nik/:nama/:jk/:tgl_lhr/:nohp/:alamat/:email/:pass", func(c echo.Context) error {
		var pelamar Pelamar
		c.Bind(&pelamar)

		sqlStatement := "CALL i_pelamar(?,?,?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("nik"), c.Param("nama"), c.Param("jk"), c.Param("tgl_lhr"), c.Param("nohp"), c.Param("alamat"), c.Param("email"), c.Param("pass"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pelamar)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/pelamar/put/:id/:nik/:nama/:jk/:tgl_lhr/:nohp/:alamat/:email/:pass", func(c echo.Context) error {
		var pelamar Pelamar
		c.Bind(&pelamar)

		sqlStatement := "CALL u_pelamar(?,?,?,?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), c.Param("nik"), c.Param("nama"), c.Param("jk"), c.Param("tgl_lhr"), c.Param("nohp"), c.Param("alamat"), c.Param("email"), c.Param("pass"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pelamar)
		}
		return c.String(http.StatusOK, "ok")
	})
	// Pelamar

	// Pendidikan
	e.GET("/api/pnddkn/get/:id", func(c echo.Context) error {
		sqlStatement := "CALL sp_pnddkn(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var pnddkn []Pendidikan
		for res.Next() {
			var m Pendidikan
			_ = res.Scan(&m.Id_Pendidikan, &m.Id_Pelamar, &m.Sekolah, &m.Jurusan, &m.Nilai, &m.Thn_Lulus)
			pnddkn = append(pnddkn, m)
		}

		return c.JSON(http.StatusOK, pnddkn)
	})

	e.POST("/api/pnddkn/post", func(c echo.Context) error {
		var pnddkn Pendidikan
		c.Bind(&pnddkn)

		sqlStatement := "CALL i_pnddkn(?,?,?,?,?)"
		res, err := db.Query(sqlStatement, pnddkn.Id_Pelamar, pnddkn.Sekolah, pnddkn.Jurusan, pnddkn.Nilai, pnddkn.Thn_Lulus)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pnddkn)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/pnddkn/put/:id", func(c echo.Context) error {
		var pnddkn Pendidikan
		c.Bind(&pnddkn)

		sqlStatement := "CALL u_pnddkn(?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), pnddkn.Sekolah, pnddkn.Jurusan, pnddkn.Nilai, pnddkn.Thn_Lulus)

		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pnddkn)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.DELETE("/api/pnddkn/delete/:id", func(c echo.Context) error {
		var pnddkn Pendidikan
		c.Bind(&pnddkn)

		sqlStatement := "CALL d_pnddkn(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pnddkn)
		}
		return c.String(http.StatusOK, "ok")
	})
	// Pendidikan

	// Pengalaman
	e.GET("/api/pnglmn/get/:id", func(c echo.Context) error {
		sqlStatement := "CALL sp_pnglmn(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var pnglmn []Pengalaman
		for res.Next() {
			var m Pengalaman
			_ = res.Scan(&m.Id_Pengalaman, &m.Id_Pelamar, &m.Perusahaan, &m.Posisi, &m.F_Date, &m.L_Date, &m.Deskripsi)
			pnglmn = append(pnglmn, m)
		}

		return c.JSON(http.StatusOK, pnglmn)
	})

	e.POST("/api/pnglmn/post/:plmr/:prshn/:pssi/:fd/:ld/:desk", func(c echo.Context) error {
		var pnglmn Pengalaman
		c.Bind(&pnglmn)

		sqlStatement := "CALL i_pnglmn(?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("plmr"), c.Param("prshn"), c.Param("pssi"), c.Param("fd"), c.Param("ld"), c.Param("desk"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pnglmn)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/pnglmn/put/:id/:prshn/:pssi/:fd/:ld/:desk", func(c echo.Context) error {
		var pnglmn Pengalaman
		c.Bind(&pnglmn)

		sqlStatement := "CALL u_pnglmn(?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), c.Param("prshn"), c.Param("pssi"), c.Param("fd"), c.Param("ld"), c.Param("desk"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pnglmn)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.DELETE("/api/pnglmn/delete/:id", func(c echo.Context) error {
		var pnglmn Pengalaman
		c.Bind(&pnglmn)

		sqlStatement := "CALL d_pnglmn(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, pnglmn)
		}
		return c.String(http.StatusOK, "ok")
	})
	// Pengalaman

	// Loker
	e.GET("/api/loker/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_loker")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var loker []Loker
		for res.Next() {
			var m Loker
			_ = res.Scan(&m.Id_Loker, &m.Posisi, &m.Cabang, &m.Deskripsi, &m.Gaji, &m.Status, &m.Tgl_Publish)
			loker = append(loker, m)
		}

		return c.JSON(http.StatusOK, loker)
	})

	e.GET("/api/loker_a/get", func(c echo.Context) error {
		res, err := db.Query("CALL saa_loker")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var loker []Loker
		for res.Next() {
			var m Loker
			_ = res.Scan(&m.Id_Loker, &m.Posisi, &m.Cabang, &m.Deskripsi, &m.Gaji, &m.Status, &m.Tgl_Publish)
			loker = append(loker, m)
		}

		return c.JSON(http.StatusOK, loker)
	})

	e.GET("/api/loker/get/random", func(c echo.Context) error {
		res, err := db.Query("CALL sal_loker")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var loker []Loker
		for res.Next() {
			var m Loker
			_ = res.Scan(&m.Id_Loker, &m.Posisi, &m.Cabang, &m.Deskripsi, &m.Gaji, &m.Status, &m.Tgl_Publish)
			loker = append(loker, m)
		}

		return c.JSON(http.StatusOK, loker)
	})

	e.GET("/api/loker/get/:id", func(c echo.Context) error {
		sqlStatement := "CALL sp_loker(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var loker []Loker
		for res.Next() {
			var m Loker
			_ = res.Scan(&m.Id_Loker, &m.Posisi, &m.Cabang, &m.Deskripsi, &m.Gaji, &m.Status, &m.Tgl_Publish)
			loker = append(loker, m)
		}

		return c.JSON(http.StatusOK, loker)
	})

	e.GET("/api/loker/search/:cabang", func(c echo.Context) error {
		sqlStatement := "CALL spl_loker(?)"
		res, err := db.Query(sqlStatement, c.Param("cabang"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var loker []Loker
		for res.Next() {
			var m Loker
			_ = res.Scan(&m.Id_Loker, &m.Posisi, &m.Cabang, &m.Deskripsi, &m.Gaji, &m.Status, &m.Tgl_Publish)
			loker = append(loker, m)
		}

		return c.JSON(http.StatusOK, loker)
	})

	e.POST("/api/loker/post", func(c echo.Context) error {
		var loker Loker
		c.Bind(&loker)

		sqlStatement := "CALL i_loker(?,?,?,?)"
		res, err := db.Query(sqlStatement, loker.Posisi, loker.Cabang, loker.Deskripsi, loker.Gaji)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, loker)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/loker/put/:id", func(c echo.Context) error {
		var loker Loker
		c.Bind(&loker)

		sqlStatement := "CALL u_loker(?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), loker.Posisi, loker.Cabang, loker.Deskripsi, loker.Gaji, loker.Status)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, loker)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/loker/delete/:id", func(c echo.Context) error {
		var loker Loker
		c.Bind(&loker)

		sqlStatement := "CALL d_loker(?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), loker.Status)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, loker)
		}
		return c.String(http.StatusOK, "ok")
	})
	// Loker

	// Melamar
	e.GET("/api/melamar/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_melamar")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var mlmr []Melamar
		for res.Next() {
			var m Melamar
			_ = res.Scan(&m.Id_Melamar, &m.Id_Loker, &m.Id_Pelamar, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai, &m.Tgl)
			mlmr = append(mlmr, m)
		}

		return c.JSON(http.StatusOK, mlmr)
	})

	e.GET("/api/melamar/get/kualifikasi/:k", func(c echo.Context) error {
		sqlStatement := "CALL k_melamar(?)"
		res, err := db.Query(sqlStatement, c.Param("k"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var mlmr []Melamar
		for res.Next() {
			var m Melamar
			_ = res.Scan(&m.Id_Melamar, &m.Id_Loker, &m.Id_Pelamar, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai, &m.Tgl)
			mlmr = append(mlmr, m)
		}

		return c.JSON(http.StatusOK, mlmr)
	})

	e.GET("/api/melamar/get/:nik", func(c echo.Context) error {
		sqlStatement := "CALL spl_melamar(?)"
		res, err := db.Query(sqlStatement, c.Param("nik"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var mlmr []Melamar
		for res.Next() {
			var m Melamar
			_ = res.Scan(&m.Id_Melamar, &m.Id_Loker, &m.Id_Pelamar, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai, &m.Tgl)
			mlmr = append(mlmr, m)
		}

		return c.JSON(http.StatusOK, mlmr)
	})

	e.GET("/api/melamar/get/pelamar/:id", func(c echo.Context) error {
		sqlStatement := "CALL sp_melamar(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var mlmr []Melamar
		for res.Next() {
			var m Melamar
			_ = res.Scan(&m.Id_Melamar, &m.Id_Loker, &m.Id_Pelamar, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai, &m.Tgl)
			mlmr = append(mlmr, m)
		}

		return c.JSON(http.StatusOK, mlmr)
	})

	e.GET("/api/melamar/get/loker/:pelamar/:loker", func(c echo.Context) error {
		sqlStatement := "CALL c_melamar(?,?)"
		res, err := db.Query(sqlStatement, c.Param("pelamar"), c.Param("loker"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var mlmr []Melamar
		for res.Next() {
			var m Melamar
			_ = res.Scan(&m.Id_Melamar, &m.Id_Loker, &m.Id_Pelamar, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai, &m.Tgl)
			mlmr = append(mlmr, m)
		}

		return c.JSON(http.StatusOK, mlmr)
	})

	e.GET("/api/melamar/get/search/:k/:c", func(c echo.Context) error {
		sqlStatement := "CALL l_melamar(?,?)"
		res, err := db.Query(sqlStatement, c.Param("k"), c.Param("c"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var mlmr []Melamar
		for res.Next() {
			var m Melamar
			_ = res.Scan(&m.Id_Melamar, &m.Id_Loker, &m.Id_Pelamar, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai, &m.Tgl)
			mlmr = append(mlmr, m)
		}

		return c.JSON(http.StatusOK, mlmr)
	})

	e.POST("/api/melamar/post/:pelamar/:loker", func(c echo.Context) error {
		var mlmr Melamar
		c.Bind(&mlmr)

		sqlStatement := "CALL i_melamar(?,?)"
		res, err := db.Query(sqlStatement, c.Param("pelamar"), c.Param("loker"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, mlmr)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/melamar/kualifikasi/:id", func(c echo.Context) error {
		var mlmr Melamar
		c.Bind(&mlmr)

		sqlStatement := "CALL u_kualifikasi(?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), mlmr.Kualifikasi)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, mlmr)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/melamar/nilai/:id/:nilai", func(c echo.Context) error {
		var mlmr Melamar
		c.Bind(&mlmr)

		sqlStatement := "CALL u_nilai(?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), c.Param("nilai"))
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, mlmr)
		}
		return c.String(http.StatusOK, "ok")
	})
	// Melamar

	// Histori Melamar
	e.GET("/api/h-melamar/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_hmlmr")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var hmlmr []H_Melamar
		for res.Next() {
			var m H_Melamar
			_ = res.Scan(&m.Id_histori, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai_Tst, &m.Aksi, &m.Tgl)
			hmlmr = append(hmlmr, m)
		}

		return c.JSON(http.StatusOK, hmlmr)
	})

	e.GET("/api/h-melamar/get/:id", func(c echo.Context) error {
		sqlStatement := "CALL sp_hmlmr(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var hmlmr []H_Melamar
		for res.Next() {
			var m H_Melamar
			_ = res.Scan(&m.Id_histori, &m.Nik, &m.Nama, &m.Posisi, &m.Cabang, &m.Kualifikasi, &m.Nilai_Tst, &m.Aksi, &m.Tgl)
			hmlmr = append(hmlmr, m)
		}

		return c.JSON(http.StatusOK, hmlmr)
	})
	// Histori Melamar

	// Cabang
	e.GET("/api/cabang/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_cabang")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var cabang []Cabang
		for res.Next() {
			var m Cabang
			_ = res.Scan(&m.Cabang)
			cabang = append(cabang, m)
		}

		return c.JSON(http.StatusOK, cabang)
	})
	// Cabang

	// Posisi
	e.GET("/api/posisi/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_posisi")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var posisi []Posisi
		for res.Next() {
			var m Posisi
			_ = res.Scan(&m.Posisi)
			posisi = append(posisi, m)
		}

		return c.JSON(http.StatusOK, posisi)
	})
	// Posisi

	// Test
	e.GET("/api/test/get", func(c echo.Context) error {
		res, err := db.Query("CALL sa_test")

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var test []Test
		for res.Next() {
			var m Test
			_ = res.Scan(&m.Id_test, &m.Pertanyaan, &m.J_a, &m.J_b, &m.J_c, &m.Jawaban, &m.Posisi)
			test = append(test, m)
		}

		return c.JSON(http.StatusOK, test)
	})

	e.GET("/api/test/get/id/:id", func(c echo.Context) error {
		sqlStatement := "CALL spl_test(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var test []Test
		for res.Next() {
			var m Test
			_ = res.Scan(&m.Id_test, &m.Pertanyaan, &m.J_a, &m.J_b, &m.J_c, &m.Jawaban, &m.Posisi)
			test = append(test, m)
		}

		return c.JSON(http.StatusOK, test)
	})

	e.GET("/api/test/get/:pss", func(c echo.Context) error {
		sqlStatement := "CALL sp_test(?)"
		res, err := db.Query(sqlStatement, c.Param("pss"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var test []Test
		for res.Next() {
			var m Test
			_ = res.Scan(&m.Id_test, &m.Pertanyaan, &m.J_a, &m.J_b, &m.J_c, &m.Jawaban, &m.Posisi)
			test = append(test, m)
		}

		return c.JSON(http.StatusOK, test)
	})

	e.POST("/api/test/post", func(c echo.Context) error {
		var test Test
		c.Bind(&test)

		sqlStatement := "CALL i_test(?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, test.Pertanyaan, test.J_a, test.J_b, test.J_c, test.Jawaban, test.Posisi)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, test)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.PUT("/api/test/put/:id", func(c echo.Context) error {
		var test Test
		c.Bind(&test)

		sqlStatement := "CALL U_test(?,?,?,?,?,?,?)"
		res, err := db.Query(sqlStatement, c.Param("id"), test.Pertanyaan, test.J_a, test.J_b, test.J_c, test.Jawaban, test.Posisi)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(res)
			return c.JSON(http.StatusCreated, test)
		}
		return c.String(http.StatusOK, "ok")
	})

	e.DELETE("/api/test/delete/:id", func(c echo.Context) error {
		sqlStatement := "CALL d_test(?)"
		res, err := db.Query(sqlStatement, c.Param("id"))

		defer res.Close()

		if err != nil {
			log.Fatal(err)
		}
		var test []Test
		for res.Next() {
			var m Test
			_ = res.Scan(&m.Id_test, &m.Pertanyaan, &m.J_a, &m.J_b, &m.J_c, &m.Jawaban, &m.Posisi)
			test = append(test, m)
		}

		return c.JSON(http.StatusOK, test)
	})
	// Test

	e.Logger.Fatal(e.Start(":1323"))
}
