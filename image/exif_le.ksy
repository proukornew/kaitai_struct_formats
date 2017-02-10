meta:
  id: exif_le
  endian: le
seq:
  - id: version
    type: u2
  - id: ifd0_ofs
    type: u4
instances:
  ifd0:
    type: ifd
    pos: ifd0_ofs
types:
  ifd:
    seq:
      - id: num_fields
        type: u2
      - id: fields
        type: ifd_field
        repeat: expr
        repeat-expr: num_fields
      - id: next_ifd_ofs
        type: u4
    instances:
      next_ifd:
        pos: next_ifd_ofs
        type: ifd
        if: next_ifd_ofs != 0
  ifd_field:
    seq:
      - id: tag
        type: u2
        enum: tag_enum
      - id: field_type
        type: u2
        enum: field_type_enum
      - id: length
        type: u4
      - id: ofs_or_data
        type: u4
    instances:
      type_byte_length:
        value: 'field_type == field_type_enum::word ? 2 : (field_type == field_type_enum::dword ? 4 : 1)'
      byte_length:
        value: length * type_byte_length
      is_immediate_data:
        value: 'byte_length <= 4'
      data:
        pos: ofs_or_data
        size: byte_length
        if: not is_immediate_data
        io: _root._io
    enums:
      field_type_enum:
        1: byte
        2: ascii_string
        3: word
        4: dword
        5: rational
      tag_enum:
        0x0100: image_width
        0x0101: image_height
        0x0102: bits_per_sample
        0x0103: compression
        0x0106: photometric_interpretation
        0x0107: thresholding
        0x0108: cell_width
        0x0109: cell_length
        0x010a: fill_order
        0x010d: document_name
        0x010e: image_description
        0x010f: make
        0x0110: model
        0x0111: strip_offsets
        0x0112: orientation
        0x0115: samples_per_pixel
        0x0116: rows_per_strip
        0x0117: strip_byte_counts
        0x0118: min_sample_value
        0x0119: max_sample_value
        0x011a: x_resolution
        0x011b: y_resolution
        0x011c: planar_configuration
        0x011d: page_name
        0x011e: x_position
        0x011f: y_position
        0x0120: free_offsets
        0x0121: free_byte_counts
        0x0122: gray_response_unit
        0x0123: gray_response_curve
        0x0124: t4_options
        0x0125: t6_options
        0x0128: resolution_unit
        0x0129: page_number
        0x012c: color_response_unit
        0x012d: transfer_function
        0x0131: software
        0x0132: modify_date
        0x013b: artist
        0x013c: host_computer
        0x013d: predictor
        0x013e: white_point
        0x013f: primary_chromaticities
        0x0140: color_map
        0x0141: halftone_hints
        0x0142: tile_width
        0x0143: tile_length
        0x0144: tile_offsets
        0x0145: tile_byte_counts
        0x0146: bad_fax_lines
        0x0147: clean_fax_data
        0x0148: consecutive_bad_fax_lines
        0x014a: sub_ifd
        0x014c: ink_set
        0x014d: ink_names
        0x014e: numberof_inks
        0x0150: dot_range
        0x0151: target_printer
        0x0152: extra_samples
        0x0153: sample_format
        0x0154: s_min_sample_value
        0x0155: s_max_sample_value
        0x0156: transfer_range
        0x0157: clip_path
        0x0158: x_clip_path_units
        0x0159: y_clip_path_units
        0x015a: indexed
        0x015b: jpeg_tables
        0x015f: opi_proxy
        0x0190: global_parameters_ifd
        0x0191: profile_type
        0x0192: fax_profile
        0x0193: coding_methods
        0x0194: version_year
        0x0195: mode_number
        0x01b1: decode
        0x01b2: default_image_color
        0x01b3: t82_options
        0x01b5: jpeg_tables2
        0x0200: jpeg_proc
        0x0201: thumbnail_offset
        0x0202: thumbnail_length
        0x0203: jpeg_restart_interval
        0x0205: jpeg_lossless_predictors
        0x0206: jpeg_point_transforms
        0x0207: jpegq_tables
        0x0208: jpegdc_tables
        0x0209: jpegac_tables
        0x0211: y_cb_cr_coefficients
        0x0212: y_cb_cr_sub_sampling
        0x0213: y_cb_cr_positioning
        0x0214: reference_black_white
        0x022f: strip_row_counts
        0x02bc: application_notes
        0x03e7: uspto_miscellaneous
        0x1000: related_image_file_format
        0x1001: related_image_width
        0x1002: related_image_height
        0x4746: rating
        0x4747: xp_dip_xml
        0x4748: stitch_info
        0x4749: rating_percent
        0x7000: sony_raw_file_type
        0x7032: light_falloff_params
        0x7035: chromatic_aberration_corr_params
        0x7037: distortion_corr_params
        0x800d: image_id
        0x80a3: wang_tag1
        0x80a4: wang_annotation
        0x80a5: wang_tag3
        0x80a6: wang_tag4
        0x80b9: image_reference_points
        0x80ba: region_xform_tack_point
        0x80bb: warp_quadrilateral
        0x80bc: affine_transform_mat
        0x80e3: matteing
        0x80e4: data_type
        0x80e5: image_depth
        0x80e6: tile_depth
        0x8214: image_full_width
        0x8215: image_full_height
        0x8216: texture_format
        0x8217: wrap_modes
        0x8218: fov_cot
        0x8219: matrix_world_to_screen
        0x821a: matrix_world_to_camera
        0x827d: model2
        0x828d: cfa_repeat_pattern_dim
        0x828e: cfa_pattern2
        0x828f: battery_level
        0x8290: kodak_ifd
        0x8298: copyright
        0x829a: exposure_time
        0x829d: f_number
        0x82a5: md_file_tag
        0x82a6: md_scale_pixel
        0x82a7: md_color_table
        0x82a8: md_lab_name
        0x82a9: md_sample_info
        0x82aa: md_prep_date
        0x82ab: md_prep_time
        0x82ac: md_file_units
        0x830e: pixel_scale
        0x8335: advent_scale
        0x8336: advent_revision
        0x835c: uic1_tag
        0x835d: uic2_tag
        0x835e: uic3_tag
        0x835f: uic4_tag
        0x83bb: iptc_naa
        0x847e: intergraph_packet_data
        0x847f: intergraph_flag_registers
        0x8480: intergraph_matrix
        0x8481: ingr_reserved
        0x8482: model_tie_point
        0x84e0: site
        0x84e1: color_sequence
        0x84e2: it8_header
        0x84e3: raster_padding
        0x84e4: bits_per_run_length
        0x84e5: bits_per_extended_run_length
        0x84e6: color_table
        0x84e7: image_color_indicator
        0x84e8: background_color_indicator
        0x84e9: image_color_value
        0x84ea: background_color_value
        0x84eb: pixel_intensity_range
        0x84ec: transparency_indicator
        0x84ed: color_characterization
        0x84ee: hc_usage
        0x84ef: trap_indicator
        0x84f0: cmyk_equivalent
        0x8546: sem_info
        0x8568: afcp_iptc
        0x85b8: pixel_magic_jbig_options
        0x85d7: jpl_carto_ifd
        0x85d8: model_transform
        0x8602: wb_grgb_levels
        0x8606: leaf_data
        0x8649: photoshop_settings
        0x8769: exif_offset
        0x8773: icc_profile
        0x877f: tiff_fx_extensions
        0x8780: multi_profiles
        0x8781: shared_data
        0x8782: t88_options
        0x87ac: image_layer
        0x87af: geo_tiff_directory
        0x87b0: geo_tiff_double_params
        0x87b1: geo_tiff_ascii_params
        0x87be: jbig_options
        0x8822: exposure_program
        0x8824: spectral_sensitivity
        0x8825: gps_info
        0x8827: iso
        0x8828: opto_electric_conv_factor
        0x8829: interlace
        0x882a: time_zone_offset
        0x882b: self_timer_mode
        0x8830: sensitivity_type
        0x8831: standard_output_sensitivity
        0x8832: recommended_exposure_index
        0x8833: iso_speed
        0x8834: iso_speed_latitudeyyy
        0x8835: iso_speed_latitudezzz
        0x885c: fax_recv_params
        0x885d: fax_sub_address
        0x885e: fax_recv_time
        0x8871: fedex_edr
        0x888a: leaf_sub_ifd
        0x9000: exif_version
        0x9003: date_time_original
        0x9004: create_date
        0x9009: google_plus_upload_code
        0x9010: offset_time
        0x9011: offset_time_original
        0x9012: offset_time_digitized
        0x9101: components_configuration
        0x9102: compressed_bits_per_pixel
        0x9201: shutter_speed_value
        0x9202: aperture_value
        0x9203: brightness_value
        0x9204: exposure_compensation
        0x9205: max_aperture_value
        0x9206: subject_distance
        0x9207: metering_mode
        0x9208: light_source
        0x9209: flash
        0x920a: focal_length
        0x920b: flash_energy
        0x920c: spatial_frequency_response
        0x920d: noise
        0x920e: focal_plane_x_resolution
        0x920f: focal_plane_y_resolution
        0x9210: focal_plane_resolution_unit
        0x9211: image_number
        0x9212: security_classification
        0x9213: image_history
        0x9214: subject_area
        0x9215: exposure_index
        0x9216: tiff_ep_standard_id
        0x9217: sensing_method
        0x923a: cip3_data_file
        0x923b: cip3_sheet
        0x923c: cip3_side
        0x923f: sto_nits
        0x927c: maker_note
        0x9286: user_comment
        0x9290: sub_sec_time
        0x9291: sub_sec_time_original
        0x9292: sub_sec_time_digitized
        0x932f: ms_document_text
        0x9330: ms_property_set_storage
        0x9331: ms_document_text_position
        0x935c: image_source_data
        0x9400: ambient_temperature
        0x9401: humidity
        0x9402: pressure
        0x9403: water_depth
        0x9404: acceleration
        0x9405: camera_elevation_angle
        0x9c9b: xp_title
        0x9c9c: xp_comment
        0x9c9d: xp_author
        0x9c9e: xp_keywords
        0x9c9f: xp_subject
        0xa000: flashpix_version
        0xa001: color_space
        0xa002: exif_image_width
        0xa003: exif_image_height
        0xa004: related_sound_file
        0xa005: interop_offset
        0xa010: samsung_raw_pointers_offset
        0xa011: samsung_raw_pointers_length
        0xa101: samsung_raw_byte_order
        0xa102: samsung_raw_unknown
        0xa20b: flash_energy2
        0xa20c: spatial_frequency_response2
        0xa20d: noise2
        0xa20e: focal_plane_x_resolution2
        0xa20f: focal_plane_y_resolution2
        0xa210: focal_plane_resolution_unit2
        0xa211: image_number2
        0xa212: security_classification2
        0xa213: image_history2
        0xa214: subject_location
        0xa215: exposure_index2
        0xa216: tiff_ep_standard_id2
        0xa217: sensing_method2
        0xa300: file_source
        0xa301: scene_type
        0xa302: cfa_pattern
        0xa401: custom_rendered
        0xa402: exposure_mode
        0xa403: white_balance
        0xa404: digital_zoom_ratio
        0xa405: focal_length_in35mm_format
        0xa406: scene_capture_type
        0xa407: gain_control
        0xa408: contrast
        0xa409: saturation
        0xa40a: sharpness
        0xa40b: device_setting_description
        0xa40c: subject_distance_range
        0xa420: image_unique_id
        0xa430: owner_name
        0xa431: serial_number
        0xa432: lens_info
        0xa433: lens_make
        0xa434: lens_model
        0xa435: lens_serial_number
        0xa480: gdal_metadata
        0xa481: gdal_no_data
        0xa500: gamma
        0xafc0: expand_software
        0xafc1: expand_lens
        0xafc2: expand_film
        0xafc3: expand_filter_lens
        0xafc4: expand_scanner
        0xafc5: expand_flash_lamp
        0xbc01: pixel_format
        0xbc02: transformation
        0xbc03: uncompressed
        0xbc04: image_type
        0xbc80: image_width2
        0xbc81: image_height2
        0xbc82: width_resolution
        0xbc83: height_resolution
        0xbcc0: image_offset
        0xbcc1: image_byte_count
        0xbcc2: alpha_offset
        0xbcc3: alpha_byte_count
        0xbcc4: image_data_discard
        0xbcc5: alpha_data_discard
        0xc427: oce_scanjob_desc
        0xc428: oce_application_selector
        0xc429: oce_id_number
        0xc42a: oce_image_logic
        0xc44f: annotations
        0xc4a5: print_im
        0xc573: original_file_name
        0xc580: uspto_original_content_type
        0xc612: dng_version
        0xc613: dng_backward_version
        0xc614: unique_camera_model
        0xc615: localized_camera_model
        0xc616: cfa_plane_color
        0xc617: cfa_layout
        0xc618: linearization_table
        0xc619: black_level_repeat_dim
        0xc61a: black_level
        0xc61b: black_level_delta_h
        0xc61c: black_level_delta_v
        0xc61d: white_level
        0xc61e: default_scale
        0xc61f: default_crop_origin
        0xc620: default_crop_size
        0xc621: color_matrix1
        0xc622: color_matrix2
        0xc623: camera_calibration1
        0xc624: camera_calibration2
        0xc625: reduction_matrix1
        0xc626: reduction_matrix2
        0xc627: analog_balance
        0xc628: as_shot_neutral
        0xc629: as_shot_white_xy
        0xc62a: baseline_exposure
        0xc62b: baseline_noise
        0xc62c: baseline_sharpness
        0xc62d: bayer_green_split
        0xc62e: linear_response_limit
        0xc62f: camera_serial_number
        0xc630: dng_lens_info
        0xc631: chroma_blur_radius
        0xc632: anti_alias_strength
        0xc633: shadow_scale
        0xc634: sr2_private
        0xc635: maker_note_safety
        0xc640: raw_image_segmentation
        0xc65a: calibration_illuminant1
        0xc65b: calibration_illuminant2
        0xc65c: best_quality_scale
        0xc65d: raw_data_unique_id
        0xc660: alias_layer_metadata
        0xc68b: original_raw_file_name
        0xc68c: original_raw_file_data
        0xc68d: active_area
        0xc68e: masked_areas
        0xc68f: as_shot_icc_profile
        0xc690: as_shot_pre_profile_matrix
        0xc691: current_icc_profile
        0xc692: current_pre_profile_matrix
        0xc6bf: colorimetric_reference
        0xc6c5: s_raw_type
        0xc6d2: panasonic_title
        0xc6d3: panasonic_title2
        0xc6f3: camera_calibration_sig
        0xc6f4: profile_calibration_sig
        0xc6f5: profile_ifd
        0xc6f6: as_shot_profile_name
        0xc6f7: noise_reduction_applied
        0xc6f8: profile_name
        0xc6f9: profile_hue_sat_map_dims
        0xc6fa: profile_hue_sat_map_data1
        0xc6fb: profile_hue_sat_map_data2
        0xc6fc: profile_tone_curve
        0xc6fd: profile_embed_policy
        0xc6fe: profile_copyright
        0xc714: forward_matrix1
        0xc715: forward_matrix2
        0xc716: preview_application_name
        0xc717: preview_application_version
        0xc718: preview_settings_name
        0xc719: preview_settings_digest
        0xc71a: preview_color_space
        0xc71b: preview_date_time
        0xc71c: raw_image_digest
        0xc71d: original_raw_file_digest
        0xc71e: sub_tile_block_size
        0xc71f: row_interleave_factor
        0xc725: profile_look_table_dims
        0xc726: profile_look_table_data
        0xc740: opcode_list1
        0xc741: opcode_list2
        0xc74e: opcode_list3
        0xc761: noise_profile
        0xc763: time_codes
        0xc764: frame_rate
        0xc772: t_stop
        0xc789: reel_name
        0xc791: original_default_final_size
        0xc792: original_best_quality_size
        0xc793: original_default_crop_size
        0xc7a1: camera_label
        0xc7a3: profile_hue_sat_map_encoding
        0xc7a4: profile_look_table_encoding
        0xc7a5: baseline_exposure_offset
        0xc7a6: default_black_render
        0xc7a7: new_raw_image_digest
        0xc7a8: raw_to_preview_gain
        0xc7b5: default_user_crop
        0xea1c: padding
        0xea1d: offset_schema
        0xfde8: owner_name2
        0xfde9: serial_number2
        0xfdea: lens
        0xfe00: kdc_ifd
        0xfe4c: raw_file
        0xfe4d: converter
        0xfe4e: white_balance2
        0xfe51: exposure
        0xfe52: shadows
        0xfe53: brightness
        0xfe54: contrast2
        0xfe55: saturation2
        0xfe56: sharpness2
        0xfe57: smoothness
        0xfe58: moire_filter
