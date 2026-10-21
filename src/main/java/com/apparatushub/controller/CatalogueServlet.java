
package com.apparatushub;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/catalogue")
public class CatalogueServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/apparatushub?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Samruddhi123";

    public static class EquipmentItem {
        private String id;
        private String name;
        private String category;
        private String listingType;
        private String vendorOrRenter;
        private String ownerFaculty;
        private String condition;
        private int quantity;
        private String description;
        private String imageUrl;

        public EquipmentItem(String id, String name, String category, String listingType, 
                             String vendorOrRenter, String ownerFaculty, String condition, 
                             int quantity, String description, String imageUrl) {
            this.id = id;
            this.name = name;
            this.category = category;
            this.listingType = listingType;
            this.vendorOrRenter = vendorOrRenter;
            this.ownerFaculty = ownerFaculty;
            this.condition = condition;
            this.quantity = quantity;
            this.description = description;
            this.imageUrl = imageUrl;
        }

        public String getId() { return id; }
        public String getName() { return name; }
        public String getCategory() { return category; }
        public String getListingType() { return listingType; }
        public String getVendorOrRenter() { return vendorOrRenter; }
        public String getOwnerFaculty() { return ownerFaculty; }
        public String getCondition() { return condition; }
        public int getQuantity() { return quantity; }
        public String getDescription() { return description; }
        public String getImageUrl() { return imageUrl; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        List<EquipmentItem> items = new ArrayList<>();

        // Verified list with Colleges for Rent & Tech Shops for Buy
        items.add(new EquipmentItem("APP-101", "8086 Microprocessor Kit", "Microprocessor", "Buy", "Vijay Electricals & Tech", "Dr. Sharma", "Available", 15, "Intel 8086 trainer kit with LED display", "https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-102", "Digital Oscilloscope 100MHz", "Electronics", "Rent", "A. P. Shah Institute of Tech", "Prof. Patil", "Available", 8, "Dual-channel 100MHz digital storage oscilloscope", "https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-103", "Bench Vice 100mm", "Workshop", "Buy", "Industrial Hardware Mart", "Prof. Verma", "Available", 12, "Heavy duty 100mm workshop bench vice", "https://images.unsplash.com/photo-1504148455328-c376907d081c?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-104", "Vernier Caliper 0-150mm", "Measurement", "Rent", "VPM Polytechnic College", "Dr. Kulkarni", "Available", 20, "Stainless steel analog vernier caliper", "https://images.unsplash.com/photo-1581092335397-9583fe92d232?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-105", "Engineering Workshop Bench", "Workshop", "Buy", "Apex Steel Fabricators", "Prof. Kadam", "Available", 10, "Heavy-duty steel frame workbench with wooden top", "https://images.unsplash.com/photo-1581092162384-8987c1d64718?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-106", "Digital Multimeter", "Measurement", "Buy", "Fluke Electronics Store", "Dr. Rao", "Available", 18, "Auto-ranging AC/DC voltage and current meter", "https://images.unsplash.com/photo-1581092334651-ddf26d9a09d0?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-107", "Desktop Computer Set", "Computer Lab", "Rent", "KC College of Engineering", "Prof. Deshmukh", "Available", 25, "Core i7 PC setup with 24-inch monitor", "https://images.unsplash.com/photo-1587831990711-23ca6441447b?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-108", "Mechanics Pulley System", "Physics", "Buy", "SciTech Educational Traders", "Dr. Joshi", "Available", 14, "Triple-tandem metallic pulley setup for mechanics lab", "https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-109", "Mechanical Keyboards & CPUs", "Computer Lab", "Buy", "Thane Computer World", "Prof. Nair", "Available", 30, "Tactile mechanical keyboards and tower CPU units", "https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=600&q=80"));
        items.add(new EquipmentItem("APP-110", "Glass Test Tubes & Chemicals", "Chemistry Lab", "Rent", "VJTI Chemistry Dept", "Dr. Kawatkar", "Available", 40, "Borosilicate glass test tubes and lab reagent set", "https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=600&q=80"));

        request.setAttribute("catalogueItems", items);
        request.getRequestDispatcher("/catalogue.jsp").forward(request, response);
    }
}
