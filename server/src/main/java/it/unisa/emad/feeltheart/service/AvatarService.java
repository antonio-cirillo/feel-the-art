package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.avatar.AddAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarResponseDto;
import it.unisa.emad.feeltheart.dto.avatar.SetAvatarRequestDto;
import org.springframework.stereotype.Service;

@Service
public interface AvatarService {

    Boolean setAvatar(SetAvatarRequestDto request);

    Boolean addAvatar(AddAvatarRequestDto request);

    GeneratedAvatarResponseDto generateAvatar(GeneratedAvatarRequestDto request);
}
