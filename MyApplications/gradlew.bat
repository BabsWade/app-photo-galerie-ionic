package com.example.gestuteur;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import androidx.annotation.Nullable;

public class GestuteurSQLiteOpenHelper extends SQLiteOpenHelper {
    public GestuteurSQLiteOpenHelper(Context context) {
        super(context, "GesTuteur.db", null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE TUTEUR(Nom TEXT PRIMARY KEY, Prenom TEXT, Email TEXT)");
        db.execSQL("CREATE TABLE COURS(id INTEGER PRIMARY KEY AUTOINCREMENT, nomCours TEXT, jourCours Text, debutCours Text, finCours Text)");
        db.execSQL("CREATE TABLE FILIERE(id INTEGER PRIMARY KEY AUTOINCREMENT, filiere TEXT, prenom_chef_filiere TEXT, nom_chef_filiere TEXT, email_chef_filiere TEXT) ");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE if exists GesTuteur");
    }

    public boolean insererDonneeeTuteur(String Nom, String Prenom, String Email) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("Nom", Nom);
        contentValues.put("Prenom", Prenom);
        contentValues.put("Email", Email);
        long resultat = db.insert("TUTEUR", null, contentValues);
        if (resultat == -1) {
            return false;
        } else {
            return true;
        }
    }

    public boolean majDonneeeTuteur(String nom, String prenom, String email) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("nom", nom);
        contentValues.put("prenom", prenom);
        contentValues.put("email", email);

        Cursor cursor = db.rawQuery("SELECT * FROM TUTEUR WHERE nom = ?", new String[]{nom});
        if (cursor.getCount() > 0) {

            long resultat = db.update("TUTEUR", contentValues, "nom=?", new String[]{nom});
            if (resultat == -1) {
                return 