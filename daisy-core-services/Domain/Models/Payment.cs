﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Models
{
    public class Payment
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        [MaxLength(255)]
        public String Description { get; set; }

        [Required]
        [MaxLength(255)]
        public String Status { get; set; }

        [Required]
        public decimal Amount { get; set; }

        [Required]
        [MaxLength(255)]
        public String Currency { get; set; }

        public String Data { get; set; }

        [Required]
        public decimal TotalAmount { get; set; }

        [Required]
        public int Commission { get; set; }

        [Required]
        public DateTime CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public DateTime? DeletedAt { get; set; }

        [Required]
        [MaxLength(255)]
        public String ObjectId { get; set; }

        public Payment() { }
    }
}
