--Tạo database cho bài asm1
CREATE DATABASE asm1_DEP302x;
GO

-- Tạo bảng DIM_TYPE
CREATE TABLE DIM_TYPE (
    id_type INT IDENTITY(1,1) PRIMARY KEY,
    name_type VARCHAR(3)
);
GO

--Tạo bảng DIM_BREED
CREATE TABLE DIM_BREED (
    id_breed INT IDENTITY(1,1) PRIMARY KEY,
    name_breed VARCHAR(255)
);
GO

--Tạo bảng DIM_GENDER
CREATE TABLE DIM_GENDER (
    id_gender INT IDENTITY(1,1) PRIMARY KEY,
    Gender VARCHAR(6)
);
GO

--Tạo bảng DIM_MATURITYSIZE_FURLENGTH
CREATE TABLE DIM_MATURITYSIZE_FURLENGTH (
    id_mf INT IDENTITY(1,1) PRIMARY KEY,
    MaturitySize VARCHAR(13),
	FurLength VARCHAR(13)
);
GO

--Tảo bảng DIM_HEALTH_VDS
CREATE TABLE DIM_HEALTH_VDS (
    id_hvds INT IDENTITY(1,1) PRIMARY KEY,
    Vaccinated VARCHAR(8),
	Dewomend VARCHAR(8),
	Sterilized VARCHAR(8),
	Health VARCHAR(14)
);
GO

--Tạo bảng DIM_STATE
CREATE TABLE DIM_STATE (
    id_state INT IDENTITY(1,1) PRIMARY KEY,
    name_state VARCHAR(255)
);
GO

--Tạo bảng DIM_COLOR
CREATE TABLE DIM_COLOR (
    id_color INT IDENTITY(1,1) PRIMARY KEY,
    name_color VARCHAR(255)
);
GO

--Tạo bảng FACT_PET
CREATE TABLE FACT_PET (
    PetID INT IDENTITY(1,1) PRIMARY KEY,
    id_type INT,
    id_breed1 INT,
    id_breed2 INT,
    id_state INT,
    Age INT,
    id_gender INT,
    id_color1 INT,
    id_color2 INT,
    id_color3 INT,
    id_mf INT,
    id_hvds INT,
    Quantity INT,
    Fee INT,
    RescuerID INT,
    FOREIGN KEY (id_type) REFERENCES DIM_TYPE(id_type),
    FOREIGN KEY (id_breed1) REFERENCES DIM_BREED(id_breed),
    FOREIGN KEY (id_breed2) REFERENCES DIM_BREED(id_breed),
    FOREIGN KEY (id_state) REFERENCES DIM_STATE(id_state),
	FOREIGN KEY (id_gender) REFERENCES DIM_GENDER(id_gender),
	FOREIGN KEY (id_color1) REFERENCES DIM_COLOR(id_color),
	FOREIGN KEY (id_color2) REFERENCES DIM_COLOR(id_color),
	FOREIGN KEY (id_color3) REFERENCES DIM_COLOR(id_color),
	FOREIGN KEY (id_mf) REFERENCES DIM_MATURITYSIZE_FURLENGTH(id_mf),
	FOREIGN KEY (id_hvds) REFERENCES DIM_HEALTH_VDS(id_hvds)
);
GO

-- YÊU CẦU 2: Xác định những câu truy vấn nghiệp vụ

-- Thống kê số lượng thú cưng theo từng loại sức khỏe 
SELECT
    dhvds.Health,
    COUNT(fp.PetID) AS TotalPets
FROM
    FACT_PET fp
JOIN
    DIM_HEALTH_VDS dhvds ON fp.id_hvds = dhvds.id_hvds
GROUP BY
    dhvds.Health;
GO


-- Đếm số lượng vật nuôi ở mỗi bang
SELECT DS.name_state, COUNT(FP.PetID) AS num_pets
FROM FACT_PET FP
INNER JOIN DIM_STATE DS ON FP.id_state = DS.id_state
GROUP BY DS.name_state;
GO

-- Số lượng thú cưng đã được tiêm phòng và chưa được tiêm phòng
SELECT 
    dhvds.Vaccinated,
    COUNT(fp.PetID) AS TotalQuantity
FROM FACT_PET fp
JOIN DIM_HEALTH_VDS dhvds ON fp.id_hvds = dhvds.id_hvds
GROUP BY dhvds.Vaccinated;
GO

