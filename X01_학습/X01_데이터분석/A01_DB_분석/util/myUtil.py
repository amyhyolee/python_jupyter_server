import pymysql

'''
https://pymysql.readthedocs.io/en/latest/index.html
http://pythonstudy.xyz/python/article/202-MySQL-%EC%BF%BC%EB%A6%AC

cursor.fetchmany(size=3)
cursor.lastrowid : insert

'''

class MySQLDao:
    # 기본 DB로 컨넥션 리턴
    def getConnection(self):
        return pymysql.connect(
            host='localhost',
            user='analysis',
            password='analysis',
            database='analysis',
            charset='utf8',
            port=3306,
            autocommit=False,
            cursorclass=pymysql.cursors.DictCursor
        )
    # 사용자 정의 DB로 컨넥션 리턴
    def getChangeConnection(self, param):
        return pymysql.connect(
            host       = param['host'],
            user       = param['user_id'],
            password   = param['user_pw'],
            database   = param['database'],
            charset    = param['charset'],
            port       = param['port'],
            autocommit = False,
            cursorclass= pymysql.cursors.DictCursor
        )

    def getTableLayout(self, dbName, tableName, db_param=None):
        #conn = self.getConnection()
        #cursor = conn.cursor()
        sql = '''
  SELECT ORDINAL_POSITION, COLUMN_COMMENT, COLUMN_NAME
           , CASE IS_NULLABLE WHEN 'YES' THEN 'Y' ELSE '' END AS NULLABLE
           , COLUMN_TYPE as TYPE
           , COLUMN_KEY
           , COLUMN_DEFAULT
   FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = %s
     AND TABLE_NAME = %s
'''
        #cursor.execute(sql,(dbName,tableName))
        #rows = cursor.fetchall()
        #print(rows)
        #print('count of list: ',cursor.rowcount)
        #self.close(cursor,conn)
        rows = self.select2(sql, (dbName,tableName), db_param)
        return rows

    def select(self, sql, param=None):
        conn = self.getConnection()
        cursor = conn.cursor()
        cursor.execute(sql, param)
        rows = cursor.fetchall()
        # print(rows)
        self.close(cursor, conn)
        return rows

    def select2(self, sql, param=None, db_param=None):
        if db_param is None:
            conn = self.getConnection()
        else:
            conn = self.getChangeConnection(db_param)
        cursor = conn.cursor()
        if param is None:
            cursor.execute(sql)
        else:
            cursor.execute(sql, param)
        rows = cursor.fetchall()
        #print(rows)
        self.close(cursor, conn)
        return rows

    def getTableColumnsList(self, param, db_param):
        db_param = db_param[0]
        sql = '''
  SELECT COLUMN_NAME, COLUMN_COMMENT, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, COLUMN_TYPE
       , CASE WHEN COLUMN_DEFAULT IS NOT NULL THEN 'N' WHEN IS_NULLABLE = 'YES' THEN 'Y' ELSE 'N' END AS NULL_YN
   FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA='@1'
     AND TABLE_NAME = '@2'
     AND COLUMN_NAME in (@3) 
         '''

        sql = sql.replace('@1', db_param['database'])
        sql = sql.replace('@2', param['tbl'])
        sql = sql.replace('@3', param['columns'])

        columns = param['columns'].split(",")
        order_by = 'ORDER BY CASE COLUMN_NAME '
        cnt = 0
        for c in columns:
            cnt += 1
            order_by += ' WHEN ' + c + ' THEN ' + str(cnt)
        order_by += ' END '
        sql += order_by
        #print(sql)
        rows = self.select2(sql, None, db_param)
        return rows

    # 도메인 목록
    def getDomainList(self, schema, domain=None, db_param=None):
        sql = '''
  SELECT COLUMN_COMMENT, COLUMN_NAME, COLUMN_TYPE, COUNT(*) AS CNT
    FROM information_schema.COLUMNS
   WHERE TABLE_SCHEMA = %s
   '''
        sql = sql.replace('%s', "'"+schema+"'")
        #if domain is not None:
        #    sql += " AND (COLUMN_COMMENT LIKE '%{0}%' OR COLUMN_NAME LIKE '%{0}%') "
        #sql = sql.replace('{0}', domain)
        sql += " GROUP BY COLUMN_COMMENT, COLUMN_NAME, COLUMN_TYPE "
        #print(sql)
        #rows = self.select(sql)

        rows = self.select2(sql, None, db_param)
        return rows

    # 테이블별 도메인 목록
    def getDomainListForTable(self, schema, db_param=None):
        sql = '''
  SELECT B.TABLE_COMMENT, B.TABLE_NAME, A.COLUMN_COMMENT, A.COLUMN_NAME, A.COLUMN_TYPE
    FROM information_schema.COLUMNS A
       , information_schema.TABLES B
   WHERE A.TABLE_SCHEMA = %s
     AND A.COLUMN_NAME = %s
     AND A.COLUMN_TYPE = %s
     AND A.TABLE_NAME = B.TABLE_NAME
    ORDER BY A.TABLE_NAME
        '''
        rows = self.select2(sql, schema, db_param)
        return rows

	# DB 목록
    def getDBList(self, param=None, db_param=None):
        sql = '''
        SELECT SCHEMA_NAME, DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME 
		  FROM information_schema.SCHEMATA
	  ORDER BY SCHEMA_NAME ASC
        '''
        rows = self.select2(sql, param, db_param)
        return rows

	# 테이블 목록 상세
    def getTableList3(self, schema, db_param=None):
        sql = '''
        SELECT TABLE_COMMENT, TABLE_NAME, TABLE_TYPE, ENGINE, DATA_LENGTH, TABLE_ROWS, AUTO_INCREMENT
             , date_format(CREATE_TIME, '%%Y.%%m.%%d %%H:%%i:%%s') as CREATE_TIME, date_format(UPDATE_TIME, '%%Y.%%m.%%d %%H:%%i:%%s') as UPDATE_TIME, TABLE_COLLATION
		  FROM information_schema.TABLES WHERE TABLE_SCHEMA = %s
        '''
        print(db_param)
        rows = self.select2(sql,(schema,),db_param)
        return rows

	# 테이블 목록
    def getTableList4(self, schema):
        sql = '''
        SELECT TABLE_COMMENT, TABLE_NAME
		  FROM information_schema.TABLES WHERE TABLE_SCHEMA = %s
        '''
        rows = self.select(sql,(schema,))
        return rows

    def close(self, cursor, conn):
        if cursor is not None:
            cursor.close()
        if conn is not None:
            conn.close()

    def execute(self, sql, param=None):
        conn = self.getConnection()
        cursor = conn.cursor()
        try:
            if param is None:
                affected = cursor.execute(sql)
            else:
                affected = cursor.execute(sql, param)
            conn.commit()
        except Exception as e:
            print("Error ---------", e)
            print(param)
            print(sql)
            affected = -1
            conn.rollback()
        self.close(cursor, conn)
        return affected

    def list(self, sql, param):
        rows = self.select(sql, param)
        return rows

    def tuple(self, sql, param):
        rows = self.select(sql, param)
        if rows is not None and len(rows) > 0:
            return rows[0]
        else:
            return None
    def rows(self, sql, param):
        return self.list(sql, param)
    def row(self, sql, param):
        return self.tuple(sql, param)
    def insert(self, sql, param):
        return self.execute(sql, param)
    def update(self, sql, param):
        return self.execute(sql, param)
    def delete(self, sql, param):
        return self.execute(sql, param)
    def save(self, sql, param):
        return self.execute(sql, param)

    def save(self, sql, param):
        return self.execute(sql, param)

dao = MySQLDao()

if __name__ == '__main__':
    db = MySQLDao()
    sql = '''
        select a.stock_cd
             , b.stock_nm
             , a.buy_dt
             , a.buy_price 
             , a.sell_dt
             , a.sell_price
             , a.fee
             , a.tax
             , a.order_no
             , a.account_uid
          from stock_order a
    inner join basic_stock b
            on a.stock_cd = b.stock_cd
         where a.account_uid = %(account_uid)s
      order by a.order_no desc
    '''
    print(db.list(sql, {'account_uid': 1}))
    # print(db.getDomainList('asset', '2'))