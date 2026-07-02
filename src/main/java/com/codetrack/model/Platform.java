package com.codetrack.model;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * Platform.java — Platform Model (Entity / POJO)
 * ============================================================
 * Represents a coding platform (LeetCode, GFG, Codeforces…).
 * Maps to the `platforms` table in the database.
 * ============================================================
 */
public class Platform {

    private int     id;
    private String  name;
    private String  baseUrl;
    private String  iconClass;   // Font Awesome class e.g. "fa-brands fa-leetcode"
    private String  colorHex;    // Brand color e.g. "#FFA116"
    private boolean active;

    public Platform() {}

    public Platform(String name, String baseUrl, String iconClass, String colorHex) {
        this.name      = name;
        this.baseUrl   = baseUrl;
        this.iconClass = iconClass;
        this.colorHex  = colorHex;
        this.active    = true;
    }

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }

    public String getName()                 { return name; }
    public void setName(String name)        { this.name = name; }

    public String getBaseUrl()              { return baseUrl; }
    public void setBaseUrl(String url)      { this.baseUrl = url; }

    public String getIconClass()            { return iconClass; }
    public void setIconClass(String icon)   { this.iconClass = icon; }

    public String getColorHex()             { return colorHex; }
    public void setColorHex(String color)   { this.colorHex = color; }

    public boolean isActive()               { return active; }
    public void setActive(boolean active)   { this.active = active; }

    @Override
    public String toString() {
        return "Platform{id=" + id + ", name='" + name + "'}";
    }
}
