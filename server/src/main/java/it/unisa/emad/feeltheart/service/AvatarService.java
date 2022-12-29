package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.avatar.*;
import org.springframework.stereotype.Service;

@Service
public interface AvatarService {

    SetAvatarResponseDto setAvatar(SetAvatarRequestDto request);

    SaveGeneratedAvatarResponseDto saveGeneratedAvatar(SaveGeneratedAvatarRequestDto request);

    GeneratedAvatarResponseDto generateAvatar(GeneratedAvatarRequestDto request);
}
