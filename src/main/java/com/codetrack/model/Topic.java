package com.codetrack.model;

/**
 * ============================================================
 * CodeTrack – DSA Progress Tracker
 * Topic.java — Topic Model (Entity / POJO)
 * ============================================================
 * Represents a DSA topic (Arrays, Trees, DP, etc.).
 * Maps to the `topics` table in the database.
 * ============================================================
 */
public class Topic {

    private int     id;
    private String  name;
    private String  description;
    private String  iconClass;
    private boolean active;

    public Topic() {}

    public Topic(String name, String description) {
        this.name        = name;
        this.description = description;
        this.active      = true;
    }

    public int getId()                          { return id; }
    public void setId(int id)                   { this.id = id; }

    public String getName()                     { return name; }
    public void setName(String name)            { this.name = name; }

    public String getDescription()              { return description; }
    public void setDescription(String desc)     { this.description = desc; }

    public String getIconClass()                { return iconClass; }
    public void setIconClass(String icon)       { this.iconClass = icon; }

    public boolean isActive()                   { return active; }
    public void setActive(boolean active)       { this.active = active; }

    @Override
    public String toString() {
        return "Topic{id=" + id + ", name='" + name + "'}";
    }
}
