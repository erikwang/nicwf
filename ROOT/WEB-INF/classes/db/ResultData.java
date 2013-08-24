package db;

import java.io.PrintStream;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Vector;

public class ResultData
  implements Serializable
{
  private boolean _isExecuteOk = true;
  private String[] colName = new String[0];
  private String description = "";
  private Vector<Vector> datas = null;

  ResultData(ResultSet paramResultSet, String paramString) { this.description = paramString;
    try {
      if (paramResultSet != null) {
        ResultSetMetaData localResultSetMetaData = null;
        localResultSetMetaData = paramResultSet.getMetaData();
        int i = localResultSetMetaData.getColumnCount();
        this.colName = new String[i];
        for (int j = 0; j < i; j++) {
          this.colName[j] = localResultSetMetaData.getColumnName(j + 1);
        }
        this.datas = new Vector();
        while (paramResultSet.next()) {
          Vector localVector = new Vector();
          for (int k = 0; k < i; k++) {
            localVector.add(paramResultSet.getObject(k + 1));
          }

          this.datas.add(localVector);
          localVector = null;
        }
      }
    } catch (Exception localException) {
      this._isExecuteOk = false;
      this.description = ("message: " + localException.getMessage());
      System.out.println("ResultData: " + localException.getMessage());
    } }

  ResultData(Object[][] paramArrayOfObject, String paramString)
  {
    this.description = paramString;
    try {
      if (paramArrayOfObject != null) {
        int i = paramArrayOfObject[0].length;
        this.colName = new String[i];
        for (int j = 0; j < i; j++) {
          this.colName[j] = new Integer(j).toString();
        }
        this.datas = new Vector();
        for (int j = 0; j < paramArrayOfObject.length; j++) {
          Vector localVector = new Vector();
          for (int k = 0; k < i; k++) {
            localVector.add(paramArrayOfObject[j][k]);
          }

          this.datas.add(localVector);
          localVector = null;
        }
      }
    } catch (Exception localException) {
      this._isExecuteOk = false;
      this.description = ("message: " + localException.getMessage());
      System.out.println("ResultData: " + localException.getMessage());
    }
  }

  ResultData(String paramString) {
    this._isExecuteOk = false;
    this.description = paramString;
  }

  ResultData(String paramString, boolean paramBoolean) {
    this._isExecuteOk = paramBoolean;
    this.description = paramString;
  }

  public boolean isExecuteOk() {
    return this._isExecuteOk;
  }

  public String[] getCollumName()
  {
    return this.colName;
  }

  public String getDescription() {
    return this.description;
  }

  public Vector<Vector> getDatas() {
    return this.datas;
  }
}