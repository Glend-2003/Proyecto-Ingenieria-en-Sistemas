import React, { useState, useEffect, useCallback } from "react";
import { toast } from "react-toastify";
import Compressor from 'compressorjs';

/**
 * Custom hook para gestionar la carga y compresión de imágenes
 * @param {Object} options - Opciones de configuración
 * @param {number} options.maxSizeMB - Tamaño máximo en MB
 * @param {number} options.quality - Calidad de compresión (0-1)
 * @param {function} options.onImageSelected - Callback cuando se selecciona una imagen
 * @returns {Object} Objeto con métodos y estado para manejar imágenes
 */
const useImageUpload = (options = {}) => {
  const {
    maxSizeMB = 2,         // Tamaño máximo permitido en MB
    quality = 0.8,         // Calidad de compresión (0-1)
    onImageSelected = null // Callback al seleccionar imagen
  } = options;

  const [imageFile, setImageFile] = useState(null);
  const [imagePreview, setImagePreview] = useState(null);
  const [isCompressing, setIsCompressing] = useState(false);
  const [originalFileInfo, setOriginalFileInfo] = useState(null);

  const maxSizeBytes = maxSizeMB * 1024 * 1024; // Convertir MB a bytes

  // Función para limpiar
  const clearImage = useCallback(() => {
    setImageFile(null);
    setImagePreview(null);
    setOriginalFileInfo(null);
    if (imagePreview) {
      URL.revokeObjectURL(imagePreview);
    }
  }, [imagePreview]);

  // Liberar recursos cuando el componente se desmonte
  useEffect(() => {
    return () => {
      if (imagePreview) {
        URL.revokeObjectURL(imagePreview);
      }
    };
  }, [imagePreview]);

  // Manejar la selección de archivos
  const handleFileChange = useCallback((event) => {
    const file = event.target.files[0];
    
    if (!file) {
      clearImage();
      return;
    }

    // Verificar que sea una imagen
    if (!file.type.startsWith('image/')) {
      toast.error('El archivo seleccionado no es una imagen válida');
      clearImage();
      return;
    }

    // Guardar información original del archivo
    setOriginalFileInfo({
      name: file.name,
      type: file.type,
      size: file.size,
      sizeInMB: (file.size / (1024 * 1024)).toFixed(2)
    });

    // Si la imagen es menor que el tamaño máximo y no es PNG/SVG, usarla directamente
    if (file.size <= maxSizeBytes && 
        !['image/png', 'image/svg+xml'].includes(file.type)) {
      setPreviewAndFile(file);
      return;
    }

    // Comprimir la imagen si es necesario
    setIsCompressing(true);
    new Compressor(file, {
      quality: quality,
      maxWidth: 1200,
      maxHeight: 1200,
      convertTypes: ['image/png', 'image/webp'],
      convertSize: 1000000, // Convertir PNG grandes a JPEG
      mimeType: 'image/jpeg',
      success(compressedFile) {
        console.log(`Imagen comprimida: ${(compressedFile.size / (1024 * 1024)).toFixed(2)}MB (original: ${(file.size / (1024 * 1024)).toFixed(2)}MB)`);
        setPreviewAndFile(compressedFile);
        setIsCompressing(false);
        
        if (compressedFile.size > maxSizeBytes) {
          toast.warning(`La imagen ha sido comprimida pero sigue siendo grande (${(compressedFile.size / (1024 * 1024)).toFixed(2)}MB). Considera seleccionar una imagen más pequeña.`);
        } else {
          toast.success('Imagen comprimida correctamente');
        }
      },
      error(err) {
        console.error('Error al comprimir imagen:', err);
        setIsCompressing(false);
        // Si falla la compresión, intentar usar la original
        if (file.size <= maxSizeBytes * 1.5) { // Permitimos un 50% más como margen
          setPreviewAndFile(file);
          toast.warning('No se pudo comprimir la imagen, pero se usará la original');
        } else {
          toast.error(`La imagen es demasiado grande (${(file.size / (1024 * 1024)).toFixed(2)}MB). El máximo es ${maxSizeMB}MB`);
          clearImage();
        }
      }
    });
  }, [maxSizeBytes, quality, maxSizeMB, clearImage]);

  // Función auxiliar para configurar vista previa y archivo
  const setPreviewAndFile = useCallback((file) => {
    // Liberar URL anterior si existe
    if (imagePreview) {
      URL.revokeObjectURL(imagePreview);
    }
    
    const previewURL = URL.createObjectURL(file);
    setImagePreview(previewURL);
    setImageFile(file);
    
    if (onImageSelected && typeof onImageSelected === 'function') {
      onImageSelected(file, previewURL);
    }
  }, [imagePreview, onImageSelected]);

  return {
    imageFile,
    imagePreview,
    isCompressing,
    originalFileInfo,
    handleFileChange,
    clearImage,
    maxSizeMB
  };
};

export default useImageUpload;